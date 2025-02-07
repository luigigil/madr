# ADR-002: Frontend Hosting Platform

**Date:** 2025-01-23  
**Status:** Approved  

## Context

We need to deploy our Next.js + Tailwind + shadcn/ui frontend. Our priorities
are:

1. **Seamless SSR/SSG** support.  
2. **Minimal configuration** effort.  
3. **Good developer experience** with automatic previews and easy integration
   with Git.  
4. **Reasonable cost** for our anticipated traffic.

We compared multiple hosting options (Vercel, Netlify, AWS, etc.) for this
project. Vercel stands out as the most turnkey solution for Next.js,
providing SSR, static generation, and edge functions with minimal setup.

## Decision

1. **Host the frontend on Vercel**  
   - We will connect our GitHub repo to Vercel for automatic builds
     and deployments.  
   - We’ll leverage Vercel’s serverless/edge functions for Next.js SSR
     where needed.

## Rationale

- **Native Next.js Support**: Vercel is built by the same team behind Next.js,
  ensuring first-class features and optimizations.  
- **Developer Experience**: Automatic pull request previews, integrated
  environment variable management, and global edge network.  
- **Familiarity**: Our team has experience with Vercel, reducing any
  onboarding overhead.  
- **Scalability & Performance**: Vercel’s CDN layer and edge network
  handle bursts of traffic well.

## Alternatives Considered

1. **Netlify**  
   - Also supports Next.js, but can require additional plugins/config.
     Vercel offers more direct Next.js integration.

2. **AWS S3 + CloudFront + Lambda@Edge**  
   - More granular control and potentially lower cost at scale, but
     much more complex to set up for SSR.

3. **AWS Amplify**  
   - Decent support for Next.js, but less seamless than Vercel, and
     deeper lock-in with the AWS ecosystem.

4. **Other Platforms** (Azure Static Web Apps, Firebase, Heroku)  
   - All could work, but none integrate as effortlessly with Next.js
     as Vercel.

## Consequences

- **Positive**  
  - Quick time-to-market with minimal devops overhead.  
  - Automatic previews for feature branches.  
  - Built-in global CDN, ensuring good performance and SEO benefits.

- **Negative**  
  - Pricing can increase if we have very high traffic or need larger
    serverless function memory/time.  
  - Some vendor lock-in with Vercel-specific features (edge functions).

## Diagram

![Frontend Hosting on Vercel](../diagrams/adr-002-frontend-hosting.svg)

## Follow-Up Actions

1. Create a Vercel project connected to our repo.  
2. Configure environment variables and project settings in Vercel  
   dashboard.  
3. Ensure that PR previews are set up for quick feedback.  
4. Document any specific custom settings (build commands, etc.) in our  
   project README.

