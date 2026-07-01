# Security Policy

## Supported versions

Security fixes are applied to the `main` branch of this repository.

## Reporting a vulnerability

**Please do not open public GitHub issues for security vulnerabilities.**

Instead, report through your conference's anonymous submission channel or open a private security advisory on the review repository if enabled.

Include:

- Description of the issue and potential impact
- Steps to reproduce
- Affected components (web, backend, agents)
- Suggested fix, if any

We aim to acknowledge reports within a reasonable timeframe.

## Safe usage

- Never commit `agents/.env`, API keys, or credentials to the repository.
- Run REFINE on trusted networks; the default setup binds services to localhost-oriented ports.
- Uploaded Java workspaces may contain sensitive code — treat local data directories accordingly.
