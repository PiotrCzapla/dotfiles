solveit() {
    (
        cd "$HOME/work" || return 1
        unset VIRTUAL_ENV
        uv run --project "$HOME/work/aai-ws" solveit "$@"
    )
}
