# Anonymization report (double-blind review)

This document records anonymization applied to the public REFINE repository for peer review.

## Scope

- **Target:** GitHub submission repository (`ResearchAnonymized/REFINE`)
- **Goal:** Remove author-identifying metadata without changing tool behavior
- **Date:** 2026 (automated pass + manual review checklist)

## Changes applied

### Author and institution identifiers

| Finding | Action |
|---------|--------|
| Local path `/Users/svm648/...` in docs and UI | Replaced with repository-relative paths or `./start-refine.sh` |
| Comment referencing personal username | Removed |
| `Copyright ResearchAnonymized` in LICENSE | Changed to **Anonymous Authors** |
| `refactai.com` HTTP referer header | Changed to neutral `https://anonymous.example.org/refine` |
| Default UI brand `RENDRI-R` | Default changed to **REFINE** when env unset |
| User-facing `RefactAI` error strings | Changed to **REFINE** + generic start instructions |

### Files excluded from published tree

Internal setup docs and research-only export scripts are stripped by `scripts/prepare-github-repo.sh`:

- `agents/WHERE_TO_PASTE_KEY.md`, `REFACTORING_PROMPT.md`, `CURRENT_REFACTORING_PROMPT.md`, `OPENROUTER_SETUP.md`
- `web/app/scripts/export-*.ts`, `validate-icse*.ts`, `audit-*.ts`, research backfill/verify scripts
- `wiki/`, `PLAN.md`, `MANIFEST.md`, `GITHUB_REPO_SETUP.md`
- `.env`, logs, build artifacts, study datasets

### Files intentionally retained (non-identifying)

- Package names `refactai`, `ai.refact` — internal code identifiers; renaming would break builds
- Workspace directory `.refactai/` — runtime data path convention, not author metadata
- OSS project links in `examples/README.md` — public subject systems for evaluation

## Git history risk

**Important:** Pushing to an existing repository preserves commit history. If earlier commits contained identifying messages, emails, or files:

```bash
# Option A — fresh anonymized repo (recommended for strict double-blind)
cd <repository-root>
./scripts/prepare-github-repo.sh
rm -rf .publish/Refine/.git
cd .publish/Refine
git init
git branch -M main
git remote add origin https://github.com/<anonymized-org>/REFINE.git
git add .
git commit -m "Anonymized REFINE release for double-blind review"
git push -f origin main   # only if you intend to replace history

# Option B — keep history: ensure all commits use neutral author
git config user.name "Anonymous Authors"
git config user.email "anonymous@example.com"
```

Reviewers may inspect `git log` — use **Option A** if any prior commit is sensitive.

## Manual checks still required

1. **Screenshots / images** in README or `web/app/public/` — verify no names, IDE usernames, or window titles
2. **Binary artifacts** (`examples/sample-java-repo/sample-project.zip`) — unzip and confirm no local paths inside
3. **Reviewer machine** `~/.refactai/users.json` — may contain names entered during local testing; not shipped in repo
4. **GitHub account** `ResearchAnonymized` — confirm this does not link to real identity on profile page
5. **Zenodo / supplementary** — upload study data separately; do not embed author PDFs in repo

## Re-publish after fixes

```bash
cd <repository-root>
./sync-refine.sh
./scripts/prepare-github-repo.sh
cd .publish/Refine
git add .
git commit -m "Anonymize repository for double-blind review"
git push origin main
```

## Contact placeholder

For review coordination only: `anonymous@example.com` (replace with your submission system's blind contact if required).
