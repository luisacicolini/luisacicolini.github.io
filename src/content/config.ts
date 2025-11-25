import { defineCollection, z } from 'astro:content';

const posts = defineCollection({
  schema: z.object({
    title: z.string(),
    date: z.date(),
  }),
});

const papers = defineCollection({
  schema: z.object({
    title: z.string(),
  }),
});

const talks = defineCollection({
  schema: z.object({
    title: z.string(),
  }),
});

export const collections = { 
  posts: posts, 
  papers: papers, 
  talks: talks 
};