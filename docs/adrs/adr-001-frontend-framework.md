# ADR-001: Frontend Framework and Libraries

**Date:** 2025-01-23  
**Status:** Approved  

## Context

We need a frontend solution that supports a modern, scalable web application 
with strong SEO, fast performance, and a familiar developer experience. The 
team is already comfortable with **Next.js**, which provides server-side rendering
(SSR), static site generation (SSG), and strong SEO capabilities out of the box.
For styling, the team has consistently used **Tailwind CSS** in previous projects,
and we want accessible, composable UI components we can fully customize. 

Options for frontend solutions are:
- Next.js (React)
- Nuxt (Vue)
- Angular 
- Svelte 

CSS frameworks and libraries:
- Tailwind (CSS utility-first) 
- Tailwind UI (paid Tailwind components and templates)
- DaisyUI
- Flowbite
- shadcn/ui

After considering pros/cons and our team’s expertise, **Next.js**, **Tailwind CSS**,
and **shadcn/ui** seems to be the right choice for us.

## Decision

1. Use **Next.js** for server-side rendering, static site generation, and overall
React-based development. React components can be leveraged if a React Native
application is created for mobile applications. Also, it is possible to use
PWA and avoid creating a dedicated mobile app, and using PWA features for that.
2. Use **Tailwind CSS** for utility-first styling.  
3. Use **shadcn/ui** for pre-built React components that integrate seamlessly 
with Tailwind.

## Rationale

1. **Team Experience**: The team excels at Next.js and Tailwind from previous 
projects, minimizing ramp-up time.
2. **SSR & SEO**: Next.js handles server-side rendering (and static generation)
seamlessly, improving performance and SEO.  
3. **Speed & Flexibility**: Tailwind’s utility classes speed up styling, while 
shadcn/ui provides accessible, minimal components that can be adapted to our design.  
4. **Maintainability**: We own the shadcn/ui component code within our repo,
making it easier to adjust or fix issues quickly without waiting for upstream merges.
5. **Reusability**: We have our own design system built with **shadcn/ui**. We
can move faster.

## Alternatives Considered

1. **Nuxt.js, Angular, and Svelte**  
   - All are considered good alternatives and are used in production by many
   companies. We'll stick with Next.js due to team's expertise.

2. **Other UI libraries**  
   - Company's design system was built on top of shadcn/ui, which was built on
   top of Tailwind CSS. 

## Consequences

- **Positive**  
  - Fast, SEO-friendly builds with Next.js.  
  - Efficient styling workflow using Tailwind CSS, shadcn/ui, following our own
  design system.
  - Accessible, composable components with minimal vendor lock-in.

- **Negative**  
  - Must periodically pull updates from the shadcn/ui repository (if necessary).  

## Follow-Up Actions

1. Initialize a Next.js project (latest version) with Tailwind CSS and shadcn/ui.
2. Integrate shadcn/ui components into the repo (copy relevant component files 
or import existing design system).
3. Configure Tailwind CSS and test basic styling consistency.
4. Establish a design system folder/structure for consistent usage of the 
components and utility classes (or use the existing design system).

