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
  "01.JPG": {
    title: "wheat & wales",
    location: "Wales/UK/Jul'26",
  },
  "02.JPG": {
    title: "sunset at Malpe",
    location: "Udupi/India/May'26",
  },
    "00.JPG": {
    title: "ಹಲಸಿನ ಹಣ್ಣು",
    location: "Rabbi/Italy/May'26",
  },
  "03.JPG": {
    title: "ಹಲಸಿನ ಹಣ್ಣು",
    location: "Udupi/India/May'26",
  },
  "04.JPG": {
    title: "cornwall sunrise with the girls",
    location: "St. Ives/UK/Mar'26",
  },
  "05.JPG": {
    title: "seals",
    location: "Norfolk/UK/Feb'26",
  },
  "06.JPG": {
    title: "concrete jungle",
    location: "Bukit Lawang/Sumatra/Oct'25",
  },
  "07.JPG": {
    title: "colors of singapore",
    location: "Singapore/Oct'25",
  },
  "08.JPG": {
    title: "desmalghjada",
    location: "Rabbi/Italy/Sep'25",
  },
  "09.JPG": {
    title: "home",
    location: "Rabbi/Italy/Sep'25",
  },
  "10.JPG": {
    title: "my favorite place in the world",
    location: "Rabbi/Italy/Sep'25",
  },
  "11.jpg": {
    title: "capturing the moment",
    location: "Istanbul/Türkiye/May'25",
  },
  "12.jpg": {
    title: "skye",
    location: "Isle of Skye/Scotland/Apr'25",
  },
  "13.jpg": {
    title: "on the way to skye",
    location: "Scotland/UK/Apr'25",
  },
  "14.jpg": {
    title: "lights and shadows",
    location: "Dolomites/Italy/Mar'25",
  },
  "15.JPG": {
    title: "cambridge sometimes you are magical",
    location: "Cambridge/UK/Jan'25",
  },
  "16.JPG": {
    title: "pink dusk",
    location: "Bangalore/India/Dec'24",
  },
  "17.JPG": {
    title: "tea",
    location: "Munnar/India/Dec'24",
  },
  "18.JPG": {
    title: "hawa mahal",
    location: "Jaipur/India/Dec'24",
  },
  "19.JPG": {
    title: "norfolk sea",
    location: "Norfolk/UK/Sep'24",
  },
  "20.jpg": {
    title: "dad",
    location: "Rabbi/Italy/Apr'24",
  },
  "21.jpg": {
    title: "dad and the snow",
    location: "Rabbi/Italy/Mar'24",
  },
};
