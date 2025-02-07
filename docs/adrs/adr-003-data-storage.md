# ADR-003: Data Storage Solution

**Date:** 2025-01-23  
**Status:** Proposed  

## Context

We need a primary data store for our application. Our requirements include:

1. **Reliability**: ACID transactions for consistent data.  
2. **Flexibility**: Ability to handle both structured and semi-structured data.  
3. **Team Familiarity**: Minimal learning curve for faster development.  
4. **Cost-Efficiency**: Start with low-cost or free tiers, scale as needed.

Based on our common use cases and desire for a straightforward solution,
**PostgreSQL** emerged as a leading option.

## Decision

We will adopt **PostgreSQL** as the primary database for this project.

1. **AWS RDS for PostgreSQL** with a small instance tier.  
2. If eligible, start on the **AWS free tier** to minimize costs.  
3. Monitor usage and migrate to a larger instance if traffic or data volume  
   grows beyond free tier limits.

## Rationale

- **Team Experience**: The team has experience with Postgres, reducing ramp-up  
  time.  
- **Broad Feature Set**: Postgres supports advanced queries, JSONB storage, and  
  robust indexing.  
- **Cost-Effective**: Leveraging AWS free tier (or a low-tier instance) allows  
  us to keep initial costs near zero while still using a fully managed service.  
- **Scalability**: As usage increases, we can upgrade instance sizes or move  
  to more robust configurations (e.g., Aurora, or a larger RDS instance).

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

## Consequences

- **Positive**  
  - Easy to implement with existing Postgres knowledge.  
  - Strong ecosystem of tools, libraries, and community support.  
  - Managed service handles backups and patching, reducing maintenance.

- **Negative**  
  - If traffic scales quickly, the free/low-tier instance might become  
    a bottleneck.  
  - Vendor lock-in to AWS if using RDS-specific features.  
  - Complex horizontal scaling (sharding) if data size grows very large.

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
   - If free tier expires or usage grows, move to a small instance (t3.small  
     or t3.medium) with minimal overhead.  
   - Evaluate Aurora Serverless if workloads are sporadic, but watch  
     for I/O costs.

4. **Region Choice**  
   - Select the nearest region to reduce latency and possibly cost.  
   - Some regions may have slightly different pricing.

5. **Housekeeping**  
   - Archive or purge old data not actively needed.  
   - Use efficient data types and indexing to limit bloat.

## Diagram

![PostgreSQL Data Storage on AWS](../diagrams/adr-003-data-storage.svg)

## Follow-Up Actions

1. Provision an RDS Postgres instance in a development AWS account  
   (free tier if available).  
2. Configure initial schemas and test basic read/write operations.  
3. Set up monitoring for CPU, memory, and storage usage.  
4. Document a migration path if we exceed free tier capacity.  
5. [Pending] Discuss **Sanity** integration and revise ADR if needed.
