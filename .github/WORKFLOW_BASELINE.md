# Workflow Baseline Policy

This repository defines the organization-level baseline for GitHub collaboration and CI hygiene.

## Reusable workflow reference policy

- Do **not** reference reusable workflows with floating refs such as `@master` or `@main`.
- Use immutable refs:
  - pinned commit SHA (preferred), or
  - immutable release tag.

Example:

```yaml
uses: clouddrove/github-shared-workflows/.github/workflows/tf-checks.yml@88efd7724e007c8f721a219498be29e0c9ad471b
```

## Pull request baseline

- Conventional Commit title required.
- Semantic PR title check required.
- CI checks must pass before merge.

## Terraform module baseline (org standard)

For Terraform module repositories, include:

- `terraform.required_version` in `versions.tf`
- explicit `required_providers` constraints
- pinned shared workflow refs in `.github/workflows/*`

These standards reduce supply-chain risk and improve CI reproducibility.
