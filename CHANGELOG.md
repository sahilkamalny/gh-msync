# Changelog

All notable changes to `gh-msync` will be documented in this file.

## [Unreleased]

- No changes yet.

## [v1.0.0] - 2026-02-24

### Added

- Initial public release of `gh-msync` (GitHub Multi-Sync).
- Parallel multi-repository sync workflow for local GitHub repo roots.
- Interactive configuration flow and CLI usage mode.
- Optional GitHub CLI extension entrypoint (`gh msync`).
- Homebrew formula packaging and from-source installer/uninstaller scripts.
- Cross-platform CI and verification coverage:
  - GitHub Actions CI on macOS, Windows (Git Bash), and Linux (`ubuntu-latest`)
  - Pinned Linux compatibility matrix (`debian-12`, `fedora-41`, `alpine-3.20`)
  - Workflow linting (`actionlint`), shell formatting checks (`shfmt`), docs/spelling linting (`markdownlint`, `typos`)
- Repo-local test suite with quality, smoke, behavior, real-git integration, and install/uninstall lifecycle coverage (`tests/run-all.sh` profiles).
- `COMPATIBILITY.md` support tiers and `docs/WSL-SMOKE-CHECKLIST.md` for explicit platform-scope documentation.
- `RELEASING.md` release checklist for tag, CI, and Homebrew formula workflows.

### Changed

- Unified macOS/Linux desktop integration management across install methods via shared helper (`scripts/system-integrations.sh`).
- Canonical launcher-management flags:
  - `--install-launcher`
  - `--uninstall-launcher`
  (Long-form compatibility flags `--install-integrations` / `--uninstall-integrations` remain supported.)
- README/install docs were tightened and clarified around configure-first flows, launcher-only commands, and support scope.

### Fixed

- Faster startup screen clears in macOS/Linux wrapper entrypoints and the macOS app runner to reduce visible Terminal startup noise before the app/installer UI renders.
- Launcher fallback semantics now preserve real runtime errors and only fall through on invocation failures.
- No-SSH mode now uses HTTPS clone URLs for missing repositories.
- macOS app Enter-to-close behavior and Terminal window close flow.
- Linux wrapper terminal detection and compatibility across a wider emulator set.
- Test portability issues across macOS/BSD vs GNU/Linux and Linux distro/container environments.
