#!/bin/bash

if [ -t 1 ]; then
    printf '\033[2J\033[3J\033[H'
fi

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

guake_is_running() {
    if ! command -v pgrep >/dev/null 2>&1; then
        return 1
    fi
    pgrep -x guake >/dev/null 2>&1
}

run_with_detected_terminal() {
    local launcher="$1"
    local bash_cmd
    bash_cmd="bash $(printf '%q' "$launcher")"

    # Best-effort coverage across common desktop environments and terminal emulators.
    if command -v kgx >/dev/null 2>&1; then
        kgx -- bash "$launcher"
    elif command -v gnome-terminal >/dev/null 2>&1; then
        gnome-terminal -- bash "$launcher"
    elif command -v konsole >/dev/null 2>&1; then
        konsole -e bash "$launcher"
    elif command -v xfce4-terminal >/dev/null 2>&1; then
        xfce4-terminal --command "$bash_cmd"
    elif command -v mate-terminal >/dev/null 2>&1; then
        mate-terminal -e "$bash_cmd"
    elif command -v alacritty >/dev/null 2>&1; then
        alacritty -e bash "$launcher"
    elif command -v kitty >/dev/null 2>&1; then
        kitty bash "$launcher"
    elif command -v wezterm >/dev/null 2>&1; then
        wezterm start -- bash "$launcher"
    elif command -v foot >/dev/null 2>&1; then
        foot -e bash "$launcher"
    elif command -v footclient >/dev/null 2>&1; then
        footclient -e bash "$launcher"
    elif command -v guake >/dev/null 2>&1 && guake_is_running; then
        guake --show >/dev/null 2>&1 || true
        guake -e "$bash_cmd"
    elif command -v terminator >/dev/null 2>&1; then
        terminator -e "$bash_cmd"
    elif command -v x-terminal-emulator >/dev/null 2>&1; then
        x-terminal-emulator -e "$launcher"
    elif command -v xterm >/dev/null 2>&1; then
        xterm -e bash "$launcher"
    else
        return 1
    fi

    # If a terminal launcher was successfully invoked, do not fall back to
    # direct execution even if the terminal propagates a non-zero child status.
    return 0
}

run_in_terminal() {
    local arg
    local quoted_args=()
    for arg in "$@"; do
        quoted_args+=("$(printf '%q' "$arg")")
    done

    local script_cmd
    script_cmd="$(printf '%q' "$DIR/scripts/uninstall.sh")"
    if [ ${#quoted_args[@]} -gt 0 ]; then
        script_cmd+=" ${quoted_args[*]}"
    fi

    local launcher
    launcher="$(mktemp "${TMPDIR:-/tmp}/gh-msync-uninstall.XXXXXX")"
    cat >"$launcher" <<EOF
#!/bin/bash
if [ -t 1 ]; then
    printf '\033[2J\033[3J\033[H'
fi
$script_cmd
read -r -p 'Press [Enter] to close...'
rm -f -- "$launcher"
EOF
    chmod +x "$launcher"

    if ! run_with_detected_terminal "$launcher"; then
        "$DIR/scripts/uninstall.sh" "$@"
        rm -f -- "$launcher"
    fi
}

run_in_terminal "$@"
