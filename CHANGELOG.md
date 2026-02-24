# Changelog

All notable changes to `gh-msync` will be documented in this file.

## [Unreleased]

- No changes yet.

## [v1.0.0] - 2026-02-24

### Initial release

- **Core workflow**: parallel multi-repository sync across one or more repo-root folders with safe failure handling (`git rebase --abort`), interactive configuration, headless/CLI mode, and explicit SSH/HTTPS behavior control (`--no-ssh-upgrade`).
- **Run modes**: standalone CLI (`gh-msync`) and GitHub CLI extension mode (`gh msync`).
- **Distribution**: Homebrew formula, from-source installers/uninstallers, and shared desktop integrations across install methods (macOS app + Linux launcher).
- **Launcher maintenance commands**: canonical `--install-launcher` / `--uninstall-launcher` aliases (long-form `--install-integrations` / `--uninstall-integrations` still supported).
- **Verification and compatibility**:
  - GitHub Actions CI on macOS, Windows (Git Bash), Ubuntu, plus a pinned Linux compatibility matrix (`debian-12`, `fedora-41`, `alpine-3.20`)
  - repo-local test suite (`tests/run-all.sh`) covering quality, smoke, behavior, real-git integration, and install/uninstall lifecycle paths
  - linting/tooling checks (`shellcheck`, `shfmt`, `actionlint`, `markdownlint`, `typos`)
- **Documentation**: `README.md`, `COMPATIBILITY.md`, `docs/WSL-SMOKE-CHECKLIST.md`, and `RELEASING.md`.
- **Shipped reliability polish**: launcher fallback error propagation, no-SSH HTTPS clone behavior, macOS app Enter-to-close flow, Linux terminal-wrapper compatibility, and reduced Terminal startup noise in wrapper/app entrypoints.
