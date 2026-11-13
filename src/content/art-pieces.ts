// The designs shown on /art, shared by the automaton page (src/pages/art.astro)
// and the per-design pages (src/pages/art/[design].astro).
import fs from 'node:fs';
import path from 'node:path';
import { artMeta } from './art-meta.ts';

// Each design is a folder in src/assets/art/ and becomes one state. The
// pictures are pre-rendered (resized + watermarked) by
// scripts/watermark-gallery.mjs into public/art/<folder>/, so we only need
// the source paths here.
const imageFiles = import.meta.glob(
  '../assets/art/*/*.{jpg,jpeg,png,webp,JPG,JPEG,PNG,WEBP}',
  { eager: true, query: '?url' }
);

const manifestPath = path.join(process.cwd(), 'public/art/manifest.json');
const dimensions: Record<string, { full: { width: number; height: number } }> =
  fs.existsSync(manifestPath) ? JSON.parse(fs.readFileSync(manifestPath, 'utf-8')) : {};

const OWNER = 'Luisa Cicolini';
const YEAR = new Date().getFullYear();

function titleFromName(name: string) {
  const cleaned = name
    .replace(/^\d+[-_ ]*/, '')
    .replace(/[-_]+/g, ' ')
    .replace(/\s+/g, ' ')
    .trim();
  return cleaned || 'untitled';
}

// Group the pictures by folder.
const folders = new Map<string, string[]>();
for (const filePath of Object.keys(imageFiles)) {
  const [folder, file] = filePath.split('/').slice(-2);
  folders.set(folder, [...(folders.get(folder) ?? []), file]);
}

// Only the first MAX_STATES designs (in folder order) are shown; the
// others stay in src/assets/art/ but get no state. Raise it to show more.
const MAX_STATES = 2;

export const pieces = [...folders.keys()]
  .sort((a, b) => a.localeCompare(b))
  .slice(0, MAX_STATES)
  .map((folder) => {
    const meta = artMeta[folder] ?? {};
    const files = folders.get(folder)!.sort((a, b) => a.localeCompare(b));
    const cover = meta.cover && files.includes(meta.cover) ? meta.cover : files[0];
    // Cover first, then the rest in filename order.
    const images = [cover, ...files.filter((f) => f !== cover)].map((file) => {
      const base = `${folder}/${file.replace(/\.[^.]+$/, '')}`;
      const dims = dimensions[base]?.full ?? { width: 1, height: 1 };
      return {
        thumb: `/art/${base}-thumb.webp`,
        full: `/art/${base}-full.webp`,
        width: dims.width,
        height: dims.height,
      };
    });
    return {
      folder,
      images,
      title: meta.title ?? titleFromName(folder),
      summary: meta.summary,
      medium: meta.medium,
      size: meta.size,
      year: meta.year,
      description: (meta.description ?? '')
        .split(/\n\s*\n/)
        .map((p) => p.replace(/\s+/g, ' ').trim())
        .filter(Boolean),
      via: meta.via ?? 'ε',
    };
  });

export { OWNER, YEAR, titleFromName };
export type Piece = (typeof pieces)[number];
