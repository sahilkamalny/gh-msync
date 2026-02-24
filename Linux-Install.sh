#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Some Linux file managers launch .sh files without a visible terminal.
# Spawn a terminal when available so users can follow installation output.
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
    elif command -v footclient >/dev/null 2>&1; then
        footclient -e bash "$launcher"
    elif command -v foot >/dev/null 2>&1; then
        foot -e bash "$launcher"
    elif command -v guake >/dev/null 2>&1; then
        guake -e "$bash_cmd"
    elif command -v terminator >/dev/null 2>&1; then
        terminator -e "$bash_cmd"
    elif command -v x-terminal-emulator >/dev/null 2>&1; then
        x-terminal-emulator -e bash "$launcher"
    elif command -v xterm >/dev/null 2>&1; then
        xterm -e bash "$launcher"
    else
        return 1
    fi
}

run_in_terminal() {
    local arg
    local quoted_args=()
    for arg in "$@"; do
        quoted_args+=("$(printf '%q' "$arg")")
    done

    local script_cmd
    script_cmd="$(printf '%q' "$DIR/scripts/install.sh")"
    if [ ${#quoted_args[@]} -gt 0 ]; then
        script_cmd+=" ${quoted_args[*]}"
    fi

    local launcher
    launcher="$(mktemp "${TMPDIR:-/tmp}/gh-msync-install.XXXXXX")"
    cat > "$launcher" <<EOF
#!/bin/bash
$script_cmd
read -r -p 'Press [Enter] to close...'
rm -f -- "$launcher"
EOF
    chmod +x "$launcher"

    if ! run_with_detected_terminal "$launcher"; then
        "$DIR/scripts/install.sh" "$@"
        rm -f -- "$launcher"
    fi
}

run_in_terminal "$@"
