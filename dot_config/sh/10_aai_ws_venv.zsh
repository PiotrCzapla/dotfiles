export VIRTUAL_ENV_DISABLE_PROMPT=1

_aai_ws_default_venv="$HOME/aai-ws/.venv"
if [[ -z "${VIRTUAL_ENV:-}" && -r "${_aai_ws_default_venv}/bin/activate" ]]; then
    source "${_aai_ws_default_venv}/bin/activate"
fi
unset _aai_ws_default_venv
