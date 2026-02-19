#!/bin/bash

# Get directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Project root is one level up
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

clear
"$PROJECT_ROOT/scripts/sync-github-repositories.sh"
