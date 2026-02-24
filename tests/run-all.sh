#!/bin/bash
# Run the local quality checks and non-destructive test suite.

set -euo pipefail

TESTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$TESTS_DIR/.." && pwd)"

REQUIRE_SHELLCHECK=0
for arg in "$@"; do
    case "$arg" in
        --require-shellcheck)
            REQUIRE_SHELLCHECK=1
            ;;
        *)
            echo "Unknown option: $arg" >&2
            echo "Usage: tests/run-all.sh [--require-shellcheck]" >&2
            exit 2
            ;;
    esac
done

export GH_MSYNC_TEST_REQUIRE_SHELLCHECK="$REQUIRE_SHELLCHECK"

TEST_SCRIPTS=(
    "$TESTS_DIR/quality-checks.sh"
    "$TESTS_DIR/smoke-integrations.sh"
    "$TESTS_DIR/core-behavior.sh"
    "$TESTS_DIR/real-git-sync.sh"
    "$TESTS_DIR/configure-install-uninstall.sh"
)

printf 'Running gh-msync test suite from %s\n\n' "$REPO_DIR"

for test_script in "${TEST_SCRIPTS[@]}"; do
    printf '==> %s\n' "$(basename "$test_script")"
    "$test_script"
    printf '\n'
done

printf 'ALL TESTS PASSED\n'
