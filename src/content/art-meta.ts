// Optional metadata for the designs in src/assets/art/.
// Each design is a folder (src/assets/art/<folder>/) holding its pictures,
// and becomes one state of the automaton. Key = exact folder name (e.g.
// "01-red-coat"). Every field is optional; a design with no entry here still
// shows up, titled from its folder name. Designs appear on /art in folder-name
// order, so prefix them with 00, 01, ... to set the order.
export type ArtMeta = {
  title?: string;
  medium?: string; // e.g. "oil on canvas"
  size?: string; // e.g. "30×40 cm"
  year?: string; // e.g. "2026"
  // Filename (inside the folder) of the picture shown in the state.
  // Defaults to the first file alphabetically.
  cover?: string;
  // One-liner shown under the title, both next to the state and at the
  // top of the detail view.
  summary?: string;
  // Extended description shown in the detail view, when the state is
  // clicked. Separate paragraphs with a blank line.
  description?: string;
  // Label on the arrow leading *into* this piece from the previous
  // one. Defaults to ε.
  via?: string;
};

// Extra transitions on top of the chain from one piece to the next:
// from === to is a self-loop, to before from is a back edge, and to more
// than one step after from is a skip edge. Use folder names, as above.
export type ArtEdge = { from: string; to: string; label?: string };

// Titles default to the folder name; add `title`, `medium`, `year`, `cover`,
// `via`, ... to any entry as needed. Empty fields are simply not shown.
export const artMeta: Record<string, ArtMeta> = {
  "01-striped-shirt": {
    summary: "",
    description: ``,
  },
  "02-failed-mandarin-shirt": {
    summary: "",
    description: ``,
  },
  "03-bottega-inspired-bag": {
    summary: "",
    description: ``,
  },
  "04-mayball-dress": {
    summary: "",
    description: ``,
  },
  "05-impero-trouser": {
    summary: "",
    description: ``,
  },
  "06-leather-corduroy": {
    summary: "",
    description: ``,
  },
  "07-squared-ruffled-skirt": {
    summary: "",
    description: ``,
  },
  "08-wedding-guest-dress": {
    summary: "",
    description: ``,
  },
  "coming soon": {
    summary: "",
    description: ``,
  },
};

// e.g. { from: "05-impero-trouser", to: "02-failed-mandarin-shirt", label: "b" }
export const artEdges: ArtEdge[] = [];
