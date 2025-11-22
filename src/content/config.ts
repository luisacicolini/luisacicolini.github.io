import { defineCollection, z } from 'astro:content';
import { defineConfig } from 'astro/config';

const posts = defineCollection({
  schema: z.object({
    title: z.string(),
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
  talks: talks };

export default defineConfig({
  base: '/luisacicolini.github.io/', 
});