# Architecture Documetation

## How

Here's an interesting pattern to document software's architecture.

1. Have a list of things you want to decide for your application

e.g:
| Requirement | Description | Notes |
| --------------- | --------------- | --------------- |
| Frontend Language + Frameworks | React Next, Tailwind, other | A write up of the decisions made with regards to the languages, frameworks, and plugins/modules to be used. |
| Frontend Hosting & Processing | Vercel/Netlify/S3/Other Statically Generated, SSR | A write up of the frontend hosting solutions - the platforms selected, costs associated, whether statically generated or server-side rendered and a diagram to illustrate. Plus any other valuable information to share with engineering and stakeholders. |
| Data storage | DynamoDB, Sanity, etc | A write up of the data storage solutions - the platforms/technologies selected, costs associated, they why behind the decision. |
| Authentication | Cognito, other | A write up of how we're handling authentication and keeping private information private - the platforms/technologies selected, costs associated, and security measures taken to ensure only the right eyes have access to the right data. |
| Backend Services/Architecture | AWS, Lambdas, EC2, microservices, Node | A write up and diagram of the backend architecture - platforms/tools being used, costs associated, how they relate, the why behind the decision |
| Frontend - blueprint/floor plan solution | Pre-existing npm module, 3rd party tool, custom | A write up the implementation notes on how to accomplish the blueprint/floor plan technical challenge |
| Automated testing | Tools and specifications | A write up of the tools being used for automated testing and general rules to follow on what to test and when to test for automated testing |
| Logging | Cloud Watch, Serverless, etc + logging plan - what to log, when to log, how to view | A write up for the tool(s) being used for logging, how admins can access the logs, and guidelines for what to log. There will be technical errors and user errors - logging will serve as a mechanism to get answers quickly for AOA internal, admin, and customer support. |
| Multi-environment | How to preview and test dev changes - frontend, backend, and data changes | A write up and diagram for the various environments - databases, hosting, dev/stage/multi-dev decisions, and workflow |
| Data model | Defined in Lucid charts or other | A write up and diagram to show the data model and data references. |

You may also have a list of acceptance criteria.

e.g:

| Subject | Description | 
| ------------- | -------------- |
| Secure and private | Project data and user data cannot be accessible to the outside world through the app or through any APIs. Additionally, users without permissions to other projects, can not access or view data of other projects. |
| Separate testing environment(s) | The ability for Human Spectrum and AOA to create and test projects, users, and interaction without compromising the production database. The ability to preview code changes in a static (consistent URL) environment |
| Access to logs | A non-engineer (at AOA or at Human Spectrum) can access logs to troubleshoot an issue - technical issues and user error issues (even if reported as a technical bug) |
| Technical alignment | The tech specification should not contain ambiguity or punted decisions. All engineers reading this should be able to understand with clarity the decisions made, the reason behind the decisions, and how everything flows together. |

2. For each requirement of thing you want to decide, create and ADR in markdown

Name the ADR with a pattern. e.g.: `adr-003-data-storage.md`

e.g:

```md
# ADR-003: Data Storage Solution

**Date:** YYYY-MM-DD  
**Status:** proposed | rejected | accepted | deprecated 

## Context

We need a primary data store for our application. Our requirements include:

1. **Reliability**: ACID transactions for consistent data.  
2. **Flexibility**: Ability to handle both structured and semi-structured  
   data.  
3. **Team Familiarity**: Minimal learning curve for faster development.  
4. **Cost-Efficiency**: Start with low-cost or free tiers, scale as  
   needed.

Based on our common use cases and desire for a straightforward solution,  
**PostgreSQL** emerged as a leading option. However, we also want to keep the  
door open for **Sanity** if we introduce CMS-style needs in the future.

## Decision

We will adopt **PostgreSQL** as the primary database for this project, handling  
all **non-CMS data**. Any **CMS-related content** (e.g., blogs or custom pages)  
may be stored in **Sanity** if required later.

1. **AWS RDS for PostgreSQL** with a small instance tier.  
2. If eligible, start on the **AWS free tier** to minimize costs.  
3. Monitor usage and migrate to a larger instance if traffic or data volume  
   grows beyond free tier limits.  
4. **Sanity** is optional but will be used for CMS needs if the project  
   demands it in the future.

## Rationale

- **Team Experience**: We already know Postgres well, and have used  
  Sanity before in a SaaS project to manage blogs and customizable pages.  
- **Broad Feature Set**: Postgres supports advanced queries, JSONB storage,  
  and robust indexing. Meanwhile, Sanity excels at headless CMS tasks and  
  integrates well with Next.js.  
- **Cost-Effective**: Leveraging AWS free tier (or a low-tier instance) for  
  Postgres keeps initial costs down. Sanity also offers a free tier for small  
  usage.  
- **Scalability**: As usage increases, we can upgrade the Postgres instance,  
  or adopt Sanity for user-facing content if we need a flexible CMS solution.

## Alternatives Considered

1. **MySQL/MariaDB**  
   - Also popular, but our team prefers Postgres features and syntax.  
2. **MongoDB / DynamoDB**  
   - Flexible for unstructured data, but we primarily need ACID  
     transactions.  
3. **Self-Managed Postgres on EC2**  
   - More control but increases devops overhead (patching, backups, etc.).  
4. **Other Proprietary DBs** (Microsoft SQL Server, Oracle)  
   - Expensive, overkill for this project.  
5. **Sanity as a Sole DB**  
   - Possible but not ideal for transactional or relational data; works  
     better as a CMS.

## Consequences

- **Positive**  
  - Easy to implement with existing Postgres knowledge.  
  - Potential for a clean separation: Postgres for core data, Sanity for  
    CMS.  
  - Sanity integration with Next.js is well-tested, should we need  
    CMS features.

- **Negative**  
  - If traffic scales quickly, the free/low-tier Postgres instance might  
    be a bottleneck.  
  - Vendor lock-in to AWS if using RDS-specific features.  
  - Two data sources (Postgres + Sanity) if we implement CMS, requiring  
    clear boundaries and integrations.

## Cost Considerations

1. **AWS RDS Free Tier**  
   - For new AWS accounts, up to 12 months of t2.micro or t3.micro with  
     20 GB storage.  
   - Adequate for development or low-volume production initially.

2. **Monitoring & Scaling**  
   - Track CPU, RAM, and storage usage. Upgrade when metrics approach  
     capacity.  
   - Keep backups and snapshots minimal to avoid extra storage charges.

3. **Right-Sizing**  
   - If free tier expires or usage grows, move to a small instance  
     (t3.small or t3.medium).  
   - Evaluate Aurora Serverless if workloads are sporadic, but watch  
     for I/O costs.

4. **Region Choice**  
   - Select the nearest region to reduce latency and possibly cost.  
   - Some regions may have slightly different pricing.

5. **Housekeeping**  
   - Archive or purge old data not actively needed.  
   - Use efficient data types and indexing to limit bloat.  
6. **Sanity Tier**  
   - Sanity’s free tier covers small content needs; paid plans exist  
     for higher usage.  
   - We only adopt it if CMS features arise, keeping initial  
     costs minimal.

## Diagram

-- Link to a diagram image if needed

## Follow-Up Actions

1. Provision an RDS Postgres instance in a development AWS account  
   (free tier if available).  
2. Configure initial schemas and test basic read/write operations.  
3. Set up monitoring for CPU, memory, and storage usage.  
4. Document a migration path if we exceed free tier capacity.  
5. If CMS features are needed, integrate **Sanity** for blog-like or  
   marketing content.  

```

3. If you need to come up with diagrams, use a diagram language that you can 
write code and convert it to image, such as [d2lang](https://d2lang.com/)

e.g:

```d2
User: {
  label: "User"
  shape: person
}

Vercel_Edge: {
  label: "Vercel Edge Network"
  shape: cloud
}

Nextjs_Functions: {
  label: "Next.js Serverless Functions"
  shape: rectangle
}

Backend: {
  label: "Backend APIs / DB"
  shape: cylinder
}

User -> Vercel_Edge: "HTTP/HTTPS"
Vercel_Edge -> Nextjs_Functions: "Routes SSR/SSG requests"
Nextjs_Functions -> Backend: "Fetch data if needed"
Nextjs_Functions -> Vercel_Edge: "Renders HTML"
Vercel_Edge -> User: "Final response"

```

4. Reference your diagrams in your markdown ADR files.

5. Have a script to compile your diagrams to image.

e.g.:

```bash
#!/usr/bin/env bash

# docs/diagrams/make.sh

set -e

for file in diagrams/*.d2; do
    BASE=$(basename "$file" .d2)
    d2 "$file" "diagrams/$BASE.svg"
    echo "Generated $BASE.svg"
done
```

6. Have your folder structured:

```md
docs/
├── adr/
│   ├── adr-001-frontend-framework.md
│   ├── adr-002-frontend-hosting.md
│   ├── adr-003-data-storage.md
│   ...
└── diagrams/
    ├── make.sh
    ├── adr-002-frontend-hosting.d2
    ├── adr-002-frontend-hosting.svg
    ├── adr-003-data-storage.d2
    ├── adr-003-data-storage.svg
    ...
```

7. Live your life happy.

## Why

1. Avoid large documentation with multiple sections written in word, google docs
or confluence
2. Avoid maintaning that large documentation every time you make an 
architecture decision
3. Avoid maintaining multiple diagrams archives and drawing them using your
 mouse/trackpad on tools like lucid chart, draw.io, or excalidraw
4. Every diagram update on lucid chart, draw.io, or excalidraw requires you to
manually update every documentation you have on word, gdocs or confluence.
5. Markdown is rendered on github. Non-tech people can easily navigate through 
architecture documentation without git/github experience, or having to read raw
markdown files.
6. Enforces __process__ by allowing the team to review and approve __any__ 
architecture decision in the form of Pull Request on Github.
7. Having the team reviewing and approving architecture decisions, we enforce that
everyone involved in process will understand each architecture decision.
8. Easily onboard people on the project: they can read ADRs on demand. If they 
will work on the frontend, they can start reading only ADRs related to frontend
and easily navigate through project's architecture.

## Example

[docs](./docs/)

## Reference

- [Architectural Decision Records](https://adr.github.io/)
- [Markdown Architectural Decision Records (MARDR)](https://adr.github.io/madr/)

