// Optional metadata for photos in src/assets/gallery/.
// Key = exact filename (e.g. "trieste-fog.jpg"). Every field is optional;
// a photo with no entry here still shows up, titled from its filename.
//
// NOTE: the entries below were drafted by looking at each photo, but the
// camera/film/date details are invented placeholders (as requested) — swap
// them for the real ones whenever you get a chance.
export type GalleryMeta = {
  title?: string;
  camera?: string;
  film?: string;
  location?: string;
  date?: string; // e.g. "2024" or "Mar 2024"
};

export const galleryMeta: Record<string, GalleryMeta> = {
  "l.JPG": {
    title: "cambridge sometimes you are magical",
    location: "Cambridge/UK/Jan'25",
  },
  "c.jpg": {
    title: "dad and the snow",
    location: "Rabbi/Italy/Mar'24",
  },
  "h.jpg": {
    title: "lights and shadows at Lago di Carezza",
    location: "Dolomites/Italy/Mar'25",
  },
  "k.jpg": {
    title: "on the way to skye",
    location: "Scotland/UK/Apr'25",
  },
  "a.JPG": {
    title: "my favorite place in the world",
    location: "Rabbi/Italy/Sep'25",
  },
  "m.JPG": {
    title: "desmalghjada",
    location: "Rabbi/Italy/Sep'25",
  },
  "n.JPG": {
    title: "colors of singapore",
    location: "Singapore/Oct'25",
  },
  "o.JPG": {
    title: "cornwall sunrise with the girls",
    location: "St. Ives/UK/Mar'26",
  },
  "g.JPG": {
    title: "home",
    location: "Rabbi/Italy/Sep'25",
  },
  "e.JPG": {
    title: "sunset at Malpe",
    location: "Udupi/India/May'26",
  },
  "b.JPG": {
    title: "seals",
    location: "Norfolk coast/UK/Feb'26",
  },
  "q.JPG": {
    title: "concrete jungle",
    location: "Bukit Lawang/Sumatra/Oct'25",
  },
  "p.JPG": {
    title: "norfolk sea",
    location: "Norfolk coast/UK/Sep'24",
  },
  "r.JPG": {
    title: "tea",
    location: "Munnar/India/Dec'24",
  },
  "f.JPG": {
    title: "hawa mahal",
    location: "Jaipur/India/Dec'24",
  },
  "s.JPG": {
    title: "pink dusk",
    location: "Bangalore/India/Dec'24",
  },
  "i.jpg": {
    title: "capturing the moment",
    location: "Istanbul/Türkiye/May'25",
  },
  "d.jpg": {
    title: "skye",
    location: "Isle of Skye/Scotland/Apr'25",
  },
  "j.jpg": {
    title: "dad",
    location: "Rabbi/Italy/Apr'24",
  },
};
