# Documentation Standards

## Purpose
Maintain clear, consistent, and accessible documentation across all projects.

## Document Types

### 1. README Files
Every project/repository must include a README.md with:
- Project name and description
- Prerequisites and setup instructions
- How to run locally
- How to run tests
- Deployment instructions
- Links to related documentation

### 2. Architecture Decision Records (ADRs)
- Use the ADR template (see `docs/adr/TEMPLATE.md`)
- Store in `docs/adr/` directory
- Number sequentially (ADR-0001, ADR-0002, etc.)
- Include status: proposed, accepted, deprecated, superseded

### 3. API Documentation
- OpenAPI/Swagger spec for REST APIs
- Include request/response examples
- Document authentication requirements
- Note rate limits and pagination

### 4. Code Documentation
- JSDoc/TSDoc for public functions and classes
- Inline comments for complex logic (explain WHY, not WHAT)
- Update docs when code changes

### 5. Runbooks
- Incident response procedures
- Deployment procedures
- Monitoring and alerting setup

## Writing Standards

### Style
- Use clear, concise language
- Active voice preferred
- Code examples should be complete and runnable
- Use markdown formatting consistently

### Structure
- Headers: `# H1`, `## H2`, `### H3` (no deeper than H4)
- Lists: Use `-` for unordered, `1.` for ordered
- Code: Use fenced code blocks with language specifier
- Links: Use relative paths for internal links

### Review
- Documentation changes require review same as code changes
- Technical accuracy must be verified by subject matter expert
- Keep docs updated with code changes (same PR)

## Storage
- Project docs: `docs/` directory in repository
- Company-wide: Shared knowledge base
- ADRs: `docs/adr/` directory
