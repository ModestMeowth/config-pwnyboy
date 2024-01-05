export PATH := justfile_directory() + "/env/bin:" + env_var("PATH")

@default:
    just --list

_galaxy_setup:
    ansible-galaxy install -r galaxy-requirements.yml --force

_env_setup:
    pip install -r dev-requirements.txt

setup: _env_setup _galaxy_setup

deploy *ARGS:
    ansible-playbook local.yml {{ ARGS }}

deploy_up *ARGS: _galaxy_setup
    just deploy {{ ARGS }}

_ansible_lint:
    ansible-lint -p

_ansible_syntax_check:
    ansible-playbook local.yml --syntax-check

lint: _ansible_lint _ansible_syntax_check

