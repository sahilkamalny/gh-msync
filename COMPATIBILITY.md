# Compatibility & Support Tiers

This document defines **what `gh-msync` actively verifies**, what is **best-effort**, and what is **community-tested only**.

It exists to keep platform claims clear, honest, and easy to review.

## Support tiers

### Tier 1 (CI-enforced)

These platforms/environments are covered by automated CI and are the primary compatibility baseline.

- **macOS** (`macos-latest`)
- **Linux (Ubuntu)** (`ubuntu-latest`)
- **Windows (Git Bash)** (`windows-latest`, Git Bash workflow)
- **Linux compatibility matrix** (containerized subset tests):
  - `debian-12`
  - `fedora-41`
  - `alpine-3.20`

Tier 1 is the strongest compatibility claim in this repo.

### Tier 2 (best-effort / manual smoke)

These environments are expected to work but are not currently fully CI-enforced end-to-end.

- **Windows WSL** (documented manual smoke checklist)
- **Additional Linux distros / desktop environments** beyond the current matrix
- **Linux GUI dialog variants** (`zenity` / `kdialog`) and launcher behavior across different desktop stacks

See `/Users/sahilkamalny/Scripts/gh-msync/docs/WSL-SMOKE-CHECKLIST.md` for a repeatable WSL validation flow.

### Tier 3 (community-tested / future expansion)

These environments are not currently part of the official CI baseline.

- **BSDs** (for example FreeBSD)
- **Other niche Unix-like systems**
- **Native Windows PowerShell/CMD workflows** (outside Git Bash/WSL)

## What is broadly portable vs environment-dependent

### Strongly portable (core CLI behavior)

- `gh-msync` core sync flow
- SSH/HTTPS mode behavior
- headless/CLI prompts
- repo-local test suite behavior (with profile/capability gating)

### Environment-dependent (best effort)

- Linux desktop launcher appearance/behavior (`.desktop` integration)
- Linux GUI dialogs (`zenity`, `kdialog`)
- Linux wrapper terminal auto-detection (depends on installed terminal emulator)
- macOS/desktop notifications and GUI launcher behavior

The project is designed with CLI fallbacks so missing GUI tools should not block core functionality.

## Current CI strategy (why this shape)

- **macOS + Ubuntu** catch major BSD-vs-GNU portability differences.
- **Windows Git Bash** validates the supported Windows shell mode.
- **Debian/Fedora/Alpine** provide meaningful Linux-family coverage without overfitting to one distro.
- **Pinned container versions** reduce CI drift and improve reproducibility.

## Roadmap (practical next steps)

1. Promote all Linux compatibility matrix jobs to required checks after enough stable green runs.
2. Add more high-signal Linux distros (for example openSUSE, Arch, Rocky/Alma) using the `linux-compat` profile.
3. Add FreeBSD coverage via **Cirrus CI** (or a self-hosted BSD runner) for syntax/lint/core subset tests.
4. Add optional Linux GUI smoke automation (Xvfb + `zenity`/`kdialog`) if GUI portability becomes a product priority.
5. Revisit native PowerShell/CMD support only if Windows scope expands beyond Git Bash/WSL.

## Reporting platform issues

When reporting a platform-specific issue, include:

- OS + version (for example `Fedora 41`, `Ubuntu 24.04`, `Windows 11 + Git Bash`, `WSL Ubuntu 24.04`)
- Shell (`bash`, Git Bash, WSL distro shell)
- Install method (Homebrew / from source / `gh` extension)
- Whether GUI tools are installed (`zenity`, `kdialog`)
- The exact command run and error output
