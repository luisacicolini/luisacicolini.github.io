// Generates watermarked renditions of every photo in src/assets/gallery/
// into public/gallery/, for the homepage film-strip gallery and its
// lightbox. Runs automatically before `astro dev` / `astro build` via the
// predev/prebuild npm hooks, and skips files that are already up to date.
//
// Run manually with `npm run watermark` (add --force to regenerate everything).

import { readdir, mkdir, stat, writeFile } from 'node:fs/promises';
import path from 'node:path';
import sharp from 'sharp';

const ROOT = path.resolve(import.meta.dirname, '..');
const SRC_DIR = path.join(ROOT, 'src/assets/gallery');
const OUT_DIR = path.join(ROOT, 'public/gallery');
const MANIFEST_PATH = path.join(OUT_DIR, 'manifest.json');

const COPYRIGHT_TEXT = '© L. Cicolini';
const FORCE = process.argv.includes('--force');

// [suffix, target long-edge width, jpeg/webp quality]
const RENDITIONS = [
  { suffix: 'thumb', width: 660, quality: 78 },
  { suffix: 'full', width: 1920, quality: 82 },
];

function escapeXml(str) {
  return str.replace(/[&<>"']/g, (c) => ({
    '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&apos;',
  }[c]));
}

// Builds a small, semi-transparent watermark badge sized relative to the
// image, anchored to the bottom-right corner.
function watermarkSvg(imgWidth, imgHeight) {
  const fontSize = Math.max(6, Math.round(imgWidth * 0.014));
  const paddingX = Math.round(fontSize * 0.6);
  const paddingY = Math.round(fontSize * 0.45);
  const textWidth = Math.round(COPYRIGHT_TEXT.length * fontSize * 0.56);
  const boxWidth = textWidth + paddingX * 2;
  const boxHeight = Math.round(fontSize * 1.7);
  const margin = Math.round(imgWidth * 0.02);

  const x = imgWidth - boxWidth - margin;
  const y = imgHeight - boxHeight - margin;

  return `
    <svg width="${imgWidth}" height="${imgHeight}" xmlns="http://www.w3.org/2000/svg">
      <rect x="${x}" y="${y}" width="${boxWidth}" height="${boxHeight}" rx="${boxHeight / 4}"
        fill="black" fill-opacity="0.38" />
      <text x="${x + boxWidth / 2}" y="${y + boxHeight / 2}"
        font-family="Helvetica, Arial, sans-serif" font-size="${fontSize}"
        fill="white" fill-opacity="0.92" text-anchor="middle" dominant-baseline="central">${escapeXml(COPYRIGHT_TEXT)}</text>
    </svg>
  `;
}

async function isUpToDate(srcPath, outPaths) {
  if (FORCE) return false;
  try {
    const srcStat = await stat(srcPath);
    for (const outPath of outPaths) {
      const outStat = await stat(outPath);
      if (outStat.mtimeMs < srcStat.mtimeMs) return false;
    }
    return true;
  } catch {
    return false;
  }
}

async function processImage(filename) {
  const srcPath = path.join(SRC_DIR, filename);
  const base = filename.replace(/\.[^.]+$/, '');
  const outPaths = RENDITIONS.map((r) => path.join(OUT_DIR, `${base}-${r.suffix}.webp`));

  // The manifest records each rendition's actual pixel dimensions, so the
  // page can lay out thumbnails at a shared height with the correct
  // proportional width (instead of cropping every photo into a fixed box).
  const dims = {};

  if (await isUpToDate(srcPath, outPaths)) {
    console.log(`  ↷ ${filename} (up to date)`);
    for (const { suffix } of RENDITIONS) {
      const meta = await sharp(path.join(OUT_DIR, `${base}-${suffix}.webp`)).metadata();
      dims[suffix] = { width: meta.width, height: meta.height };
    }
    return { base, dims };
  }

  for (const { suffix, width, quality } of RENDITIONS) {
    // Actually run the resize (metadata() alone reports the *original*
    // dimensions, not the post-resize ones) so the watermark SVG below is
    // sized to match the pixels it gets composited onto.
    const { data, info } = await sharp(srcPath)
      .rotate()
      .resize({ width, withoutEnlargement: true })
      .toBuffer({ resolveWithObject: true });

    const watermark = Buffer.from(watermarkSvg(info.width, info.height));

    await sharp(data)
      .composite([{ input: watermark, top: 0, left: 0 }])
      .webp({ quality })
      .toFile(path.join(OUT_DIR, `${base}-${suffix}.webp`));

    dims[suffix] = { width: info.width, height: info.height };
  }

  console.log(`  ✓ ${filename}`);
  return { base, dims };
}

async function main() {
  await mkdir(OUT_DIR, { recursive: true });

  let files;
  try {
    files = (await readdir(SRC_DIR)).filter((f) => /\.(jpe?g|png|webp)$/i.test(f));
  } catch {
    console.log('No src/assets/gallery directory found, skipping watermark generation.');
    return;
  }

  if (files.length === 0) {
    console.log('No gallery photos found, skipping watermark generation.');
    return;
  }

  console.log(`Watermarking ${files.length} gallery photo(s)...`);
  const results = await Promise.all(files.map(processImage));

  const manifest = {};
  for (const { base, dims } of results) {
    manifest[base] = dims;
  }
  await writeFile(MANIFEST_PATH, JSON.stringify(manifest, null, 2));

  console.log('Done.');
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
