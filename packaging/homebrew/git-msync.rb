# typed: false
# frozen_string_literal: true

# Git Multi-Sync: native Git subcommand to sync multiple repositories in parallel.
# https://github.com/USER/REPO
class GitMsync < Formula
  desc "Native Git subcommand to sync multiple repositories in parallel"
  homepage "https://github.com/USER/REPO"
  url "https://github.com/USER/REPO/archive/refs/tags/v0.0.0.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "MIT"
  version "0.0.0"

  depends_on "git"
  depends_on "gh"

  def install
    bin.install "scripts/git-msync" => "git-msync"
  end

  caveats <<~EOS
    Run as a Git subcommand:
      git msync

    Optional: add repository root paths to ~/.config/git-msync/config (one per line).
    If no config exists, ~/GitHub is used.
  EOS

  test do
    (testpath/"empty").mkdir
    assert_match "No Git repositories found", shell_output("#{bin}/git-msync --cli #{testpath}/empty 2>&1", 0)
  end
end
