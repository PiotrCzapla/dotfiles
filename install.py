#!/usr/bin/env python3
# %load /Users/pczapla/.local/share/chezmoi/install.py
import getpass
import os
import platform
import subprocess
import json
from pathlib import Path
from functools import partial

KEY_GRIPS=dict(enc='B9E04B24F9638F9AA96AEB23285CE99FAA64E280')
GPG_KEY_PASSPHRASE='GPG_KEY_PASSPHRASE'
USER_NAME='piotrczapla'

def run(args,**kwargs):
    try:
        return subprocess.run(
            args, **(dict(capture_output=True, text=True, check=True)|kwargs))
    except subprocess.CalledProcessError as e:
        print(e.stderr)
        raise
def dump_login_env(shell='/bin/bash'):
    s = "import os,json; print(json.dumps({**os.environ}))"
    return json.loads(run([shell, '--login', '-c', 'python'], input=s).stdout)

def load_env(*keys):
    env = dump_login_env()
    for k in keys: os.environ[k] = env[k]

def setup_chezmoi(update_env=True):
    if (Path.home()/'.local'/'share'/'chezmoi').exists(): return
    run(['/bin/sh', '-c', '$(curl -fsLS https://chezmoi.io/get)',
         '--', 'init', '--apply' , USER_NAME])
    load_env('PATH', 'SSH_AUTH_SOCK')

def gpg_preset_passphrase(passphrase, keygrip): 
    if platform.system() == 'Darwin': return # we don't need to unlock gpg on macos
    libexecdir=Path(run(f"gpgconf --list-dirs libexecdir", shell=True).stdout)
    return run([libexecdir/'gpg-preset-passphrase', '--preset', keygrip], input=passphrase)

def gpg_import(key): 
    return run(['gpg', '--pinentry-mode=loopback', '--batch', '--import'],
               input=key, capture_output=False)

def gpg_keys(): return run(['gpg', "-K"], shell=False).stdout

def gpg_encrypt(content, recipients): 
    return run(['gpg', '--encrypt',  '--armor', '-r', recipients], input=content).stdout
def gpg_decrypt(content): 
    return run(['gpg', '--batch', '--no-tty', '--decrypt'], input=content).stdout
def gpg_unlocked(): 
    return gpg_decrypt(gpg_encrypt('test', KEY_GRIPS['enc'])) == 'test'

def setup_gpgkey(gpg_key, passphrase_ask=False):
    passphrase = os.environ.get(GPG_KEY_PASSPHRASE, None) 
    if passphrase_ask and not passphrase:
        passphrase = getpass.getpass(f"Enter passphrase for gpg_key: ")
    if KEY_GRIPS['enc'] not in gpg_keys():   
        gpg_import(key=gpg_key)
    for keygrip in KEY_GRIPS.values():
        gpg_preset_passphrase(passphrase, keygrip)  

def gopass_clone(username, repo='pass'):
    if (Path.home()/'.local'/'share'/'gopass'/'stores'/'root').exists(): return
    run(['gopass', 'clone',  f'git@github.com/{username}/{repo}'])

def init(gpg_key, passphrase_ask=False):
    setup_chezmoi()
    setup_gpgkey(gpg_key, passphrase_ask)
    if gpg_unlocked():  
        gopass_clone(USER_NAME)  

if __name__ == '__main__':
    init()