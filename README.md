<div align="center">

# GitHub Sync

**Cross-platform Git repository synchronizer — pull all your repos in parallel with automatic SSH upgrades and native OS integrations.**

[![Bash](https://img.shields.io/badge/Bash-5+-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![PowerShell](https://img.shields.io/badge/PowerShell-Windows-5391FE?style=flat-square&logo=powershell&logoColor=white)](https://learn.microsoft.com/en-us/powershell/)
[![macOS](https://img.shields.io/badge/macOS-Supported-000000?style=flat-square&logo=apple&logoColor=white)](https://www.apple.com/macos/)
[![Linux](https://img.shields.io/badge/Linux-Supported-FCC624?style=flat-square&logo=linux&logoColor=black)](https://kernel.org/)
[![Windows](https://img.shields.io/badge/Windows-Supported-0078D6?style=flat-square&logo=windows&logoColor=white)](https://www.microsoft.com/windows/)

**Built with** Bash · PowerShell · GitHub CLI · AppleScript

[Portfolio](https://sahilkamal.dev) · [LinkedIn](https://linkedin.com/in/sahilkamalny) · [Contact](mailto:sahilkamal.dev@gmail.com)

</div>

---

<div align="center">
  <img src="assets/demo.gif" alt="GitHub Sync Terminal Recording" width="800">
</div>

---

## Overview

GitHub Sync is a cross-platform CLI utility that iterates over all local Git repositories and pulls them concurrently using Bash and PowerShell backends. It ships with native OS integrations — a Spotlight-searchable `.app` wrapper on macOS, a `.desktop` launcher on Linux, and a `ghsync` terminal alias — so synchronization is always one keystroke or click away. Automatic SSH remote upgrades, fail-safe rebase protections, and an interactive multi-directory configuration menu are included out of the box.

---

## Features

**Parallel Fetching** — Pulls all tracked repositories concurrently, falling back gracefully per-repo if errors occur.

**Fail-Safe Rebase Protection** — Automatically runs `git rebase --abort` on any background job that fails due to merge conflicts or network errors, preventing repositories from being left in a dirty state.

**Auto SSH Upgrades** — Detects `https://` remotes and upgrades them to `git@github.com:` SSH remotes on the fly, bypassing token authentication limits and hardcoded usernames.

**Native OS Integrations** — Generates a Spotlight-searchable macOS `.app` wrapper via AppleScript/Bash and a `.desktop` launcher on Linux desktop environments. Native notification alerts on both platforms.

**Interactive Configuration Menu** — A stateful GUI menu on macOS and Linux for multi-directory tracking, infinite folder selection, and per-folder removal via checkbox lists.

**Animated Terminal UI** — Progress spinner with sequentially resolved concurrent background jobs for a clean terminal experience.

---

## Prerequisites

- `git`
- `bash` (or Git Bash on Windows)

**Optional — Cloning missing repositories**

To detect and clone GitHub repos not yet on your local machine, the GitHub CLI (`gh`) must be installed and authenticated.

```bash
# Install (choose your platform)
brew install gh                              # macOS
sudo apt install gh                          # Debian / Ubuntu
winget install --id GitHub.cli              # Windows

# Authenticate
gh auth login
```

Once authenticated, GitHub Sync will automatically discover your account on the next run and offer to clone any missing repositories.

**Required — SSH key**

> [!IMPORTANT]
> GitHub Sync upgrades all remotes to SSH, so a GitHub SSH key must be configured on your machine.

<details>
<summary>SSH key setup instructions</summary>
<br>

Generate a key:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Press Enter to accept the default path and optionally set a passphrase. Then copy your public key and add it to GitHub under **Settings → SSH and GPG keys → New SSH key**:

```bash
pbcopy < ~/.ssh/id_ed25519.pub   # macOS
cat ~/.ssh/id_ed25519.pub        # Linux (copy output manually)
clip < ~/.ssh/id_ed25519.pub     # Windows
```

See the [official guide for adding an SSH key to GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) for full details. For troubleshooting or managing the SSH agent, refer to GitHub's [SSH key generation guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).

</details>

---

## Installation

| Platform | Method |
|---|---|
| macOS | Double-click `macOS-Install.command` |
| Linux | Double-click `Linux-Install.sh` |
| Windows | Git Bash / WSL — generic install script (dedicated installer coming soon) |
| Terminal (any) | `./scripts/install.sh` from the repo root |

The installer will automatically make scripts executable, symlink the `github-sync` CLI and `ghsync` alias to `~/.local/bin/`, configure your active shell's `$PATH`, and generate the macOS `.app` wrapper or Linux `.desktop` launcher.

---

## Usage

**Launch**

Once installed, start a sync via any of the following:
- macOS Spotlight or Launchpad — search **GitHub Sync**
- Linux application menu — launch **GitHub Sync**
- Terminal — type `github-sync` or `ghsync` from any directory

By default, the script looks for repositories in `~/GitHub`.

**Headless / CLI mode**

Bypass all graphical prompts (AppleScript, Zenity, kdialog) and fall back to a standard Bash prompt:

```bash
ghsync --cli
# or
ghsync --headless
```

**Custom paths**

Pass one or more directories as arguments to override the configured paths on the fly:

```bash
ghsync ~/ClientCode ~/SecondaryDrive
```

---

## Uninstallation

Removes the CLI symlink, desktop launcher, and configuration at `~/.config/github-sync`.

| Platform | Method |
|---|---|
| macOS | Double-click `macOS-Uninstall.command` |
| Linux | Double-click `Linux-Uninstall.sh` |
| Windows | Remove manually via Git Bash or WSL |
| Terminal (any) | `./scripts/uninstall.sh` |

---

## Contributing

Pull requests are welcome. For bugs or feature requests, please open an issue.

---

## License

MIT — see [LICENSE](LICENSE) for details.

---

<div align="center">

*© 2026 Sahil Kamal*

</div>
