# WSL Smoke Checklist

Use this checklist to validate `gh-msync` in **Windows Subsystem for Linux (WSL)**.

This is a **manual smoke checklist** (Tier 2 support), not a replacement for CI.

Related docs: [README.md](../README.md) · [COMPATIBILITY.md](../COMPATIBILITY.md) · [tests/README.md](../tests/README.md)

## Scope

This checklist validates:

- core CLI execution
- path configuration (CLI mode)
- sync behavior in a safe local temp sandbox
- SSH/HTTPS mode toggles
- optional `gh` integration (if installed/authenticated)

It does **not** attempt to validate Linux desktop GUI launchers/dialogs inside WSL.

## Prerequisites

- WSL installed (WSL2 recommended)
- `bash` and `git`
- Optional: `gh` (GitHub CLI) for missing-repo discovery/clone prompts
- Optional: `shellcheck` if you want full local test parity

## Quick environment capture (recommended)

Run and save the output with any bug report:

```bash
uname -a
cat /etc/os-release
bash --version | head -n 1
git --version
gh --version || true
```

## 1. Basic command smoke

```bash
gh-msync --help
```

Expected:

- exits `0`
- shows `--install-integrations` / `--uninstall-integrations`
- no shell syntax/runtime errors

If using extension mode:

```bash
gh msync --help
```

## 2. Configuration CLI smoke (no GUI)

```bash
gh-msync --configure --cli
```

Use one or more test directories when prompted.

Expected:

- config written to `~/.config/gh-msync/config`
- no GUI tool dependency required

## 3. Local non-destructive sync smoke (recommended)

Create a safe local sandbox:

```bash
tmp_root="$(mktemp -d)"
mkdir -p "$tmp_root/repos/demo/.git"
GH_MSYNC_DISABLE_INTEGRATIONS_AUTOSETUP=1 gh-msync --headless "$tmp_root/repos"
```

Expected:

- command exits `0`
- prints a result for `demo`
- no launcher/autosetup side effects (disabled via env var)

Cleanup:

```bash
rm -rf "$tmp_root"
```

## 4. HTTPS / SSH toggle smoke

```bash
gh-msync --help | grep -F -- "--no-ssh-upgrade"
GH_MSYNC_NO_SSH_UPGRADE=1 gh-msync --help >/dev/null
```

Expected:

- flags/env toggle parse correctly
- no runtime errors

## 5. Repo-local test suite (optional but recommended)

If dependencies are installed:

```bash
tests/run-all.sh --profile ci-posix
```

If `shellcheck` is installed and you want CI-parity:

```bash
tests/run-all.sh --profile ci-posix --require-shellcheck
```

## 6. Optional `gh` integration smoke

Only if you use `gh` and are authenticated:

```bash
gh auth status
GH_MSYNC_DISABLE_INTEGRATIONS_AUTOSETUP=1 gh-msync --headless
```

Expected:

- missing-repository discovery prompt behavior works in terminal mode
- no GUI dependency required

## Result template

```text
WSL smoke result: PASS / FAIL
WSL distro + version:
Windows version:
Shell:
Install method:
gh installed/authenticated: yes/no
tests/run-all.sh profile run: none / ci-posix / ci-posix --require-shellcheck
Notes:
```
