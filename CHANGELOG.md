# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [v3.2.0] - 2026-08-25
### :bug: Bug Fixes
- [`14cfa61`](https://github.com/terraform-az-modules/terraform-azurerm-key-vault/commit/14cfa611af6879ae7ae8c6c98cd54341f75b75e2) - updated checkov to skip some checks *(PR [#72](https://github.com/terraform-az-modules/terraform-azurerm-key-vault/pull/72) by [@rmalvia-cd](https://github.com/rmalvia-cd))*
- [`8c6bcc8`](https://github.com/terraform-az-modules/terraform-azurerm-key-vault/commit/8c6bcc8a035bed48bc225c8bbb8d6ee7ceb2e88a) - added resource vault certificate contacts  and support for the version 5.0 *(commit by [@karan-cd](https://github.com/karan-cd))*


## [2.0.1] - 2026-03-20

### Changes
- Add provider_meta for API usage tracking
- Add terraform tests and pre-commit CI workflow
- Add SECURITY.md, CONTRIBUTING.md, .releaserc.json
- Standardize pre-commit to antonbabenko v1.105.0
- Set provider: none in tf-checks for validate-only CI
- Bump required_version to >= 1.10.0
[v3.2.0]: https://github.com/terraform-az-modules/terraform-azurerm-key-vault/compare/v3.1.0...v3.2.0
