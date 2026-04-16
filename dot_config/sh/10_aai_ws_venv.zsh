export VIRTUAL_ENV_DISABLE_PROMPT=1

_aai_ws_default_venv="$HOME/work/aai-ws/.venv"

# Some terminal/app integrations leave a stale VIRTUAL_ENV exported without
# a matching PATH after the workspace moved. Keep only the canonical default.
if [[ -n "${VIRTUAL_ENV:-}" && "${VIRTUAL_ENV}" != "${_aai_ws_default_venv}" ]]; then
    unset VIRTUAL_ENV
fi

if [[ -z "${VIRTUAL_ENV:-}" && -r "${_aai_ws_default_venv}/bin/activate" ]]; then
    source "${_aai_ws_default_venv}/bin/activate"
fi
unset _aai_ws_default_venv
