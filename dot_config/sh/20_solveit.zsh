solveit() {
    (
        cd "$HOME/work" || return 1
        mkdir -p "$HOME/work/aai-ws/.venv/etc/ipython"
        echo "c.InteractiveShellApp.extensions.append('ipykernel_helper')" > "$HOME/work/aai-ws/.venv/etc/ipython/ipython_kernel_config.py"
        echo "c.InteractiveShell.display_page=True" >> "$HOME/work/aai-ws/.venv/etc/ipython/ipython_kernel_config.py"
        unset VIRTUAL_ENV
        uv run --project "$HOME/work/aai-ws" solveit "$@"
    )
}
