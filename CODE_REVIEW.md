# Code Review Checklist & Process

## Purpose
Ensure consistent code quality, knowledge sharing, and maintainability across all engineering work.

## Process

### 1. Author Responsibilities
- [ ] Code passes all automated tests locally
- [ ] ESLint and Prettier checks pass (`npm run lint && npm run format:check`)
- [ ] Pull request description includes:
  - Summary of changes
  - Testing approach
  - Screenshots/recordings (if UI changes)
  - Links to related issues
- [ ] Self-review completed before requesting review
- [ ] No debug code, console.logs, or temporary comments remain

### 2. Reviewer Responsibilities
- [ ] Review within 4 hours of request (same business day)
- [ ] Check for correctness and edge cases
- [ ] Verify security implications (auth, validation, data exposure)
- [ ] Assess performance impact
- [ ] Confirm test coverage is adequate
- [ ] Validate error handling and logging
- [ ] Check documentation updates (if API/interface changes)

### 3. Approval Criteria
- All automated checks pass (CI green)
- At least one approving review
- All review comments addressed or acknowledged
- No unresolved blocking concerns

### 4. Merge Process
- Squash merge for feature branches
- Delete branch after merge
- Verify deployment pipeline triggers correctly

### 5. Post-Merge
- Monitor for regressions
- Update issue status to done
- Communicate changes to affected teams

## Review Levels

| Change Type | Reviewers Required |
|-------------|-------------------|
| Bug fix (non-critical) | 1 |
| Feature addition | 1 |
| API change | 2 |
| Security-related | 2 + Security review |
| Database migration | 2 + DBA review |

## Escalation
If reviewer and author disagree on changes needed, escalate to tech lead or CTO for resolution.
