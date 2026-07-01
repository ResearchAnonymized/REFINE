# Contributing to REFINE

Thank you for your interest in improving REFINE.

## Getting started

1. Fork the repository and clone your fork.
2. Run first-time setup:

   ```bash
   ./scripts/setup.sh
   cp agents/.env.example agents/.env   # add your OpenRouter key for LLM features
   ```

3. Start the stack and verify:

   ```bash
   ./start-refine.sh
   ./scripts/verify-install.sh
   ```

## Pull requests

- Keep changes focused — one logical change per PR when possible.
- Match existing code style in each layer (Java, Python, TypeScript).
- Do not commit secrets (`.env`, API keys, local workspaces, or study datasets).
- Run relevant tests before opening a PR:

  ```bash
  cd agents && python -m pytest -q --ignore=test_openrouter.py
  cd backend/server && mvn test
  ```

## Reporting issues

Use the repository issue tracker and include:

- OS and versions (Java, Node, Python)
- Steps to reproduce
- Expected vs actual behavior
- Relevant log excerpts (redact API keys)

## Scope

REFINE is the runnable refactoring platform. Large evaluation datasets and paper-specific exports are maintained separately and are out of scope for this repository.
