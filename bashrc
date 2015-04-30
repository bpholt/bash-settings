export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export VAGRANT_DEFAULT_PROVIDER=parallels

complete -C aws_completer aws

