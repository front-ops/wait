import { z, defineCollection } from 'astro:content';

const cases = defineCollection({
    type: 'content',
    schema: z.object({
        title: z.string(),
        description: z.string(),
        imageSrc: z.string(),
    }),
});

const team = defineCollection({
    type: 'content',
    schema: z.object({
        firstName: z.string(),
        lastName: z.string(),
        position: z.string(),
        imageSrc: z.string(),
    }),
});

export const collections = {
    cases,
    team,
};
