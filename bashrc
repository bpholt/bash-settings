export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export VAGRANT_DEFAULT_PROVIDER=parallels

complete -C aws_completer aws


# added by travis gem
[ -f /Users/bholt/.travis/travis.sh ] && source /Users/bholt/.travis/travis.sh

# fuck you serverless
# tabtab source for serverless package
# tabtab source for sls package
# tabtab source for slss package
