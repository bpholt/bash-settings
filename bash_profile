export GITAWAREPROMPT=~/.bash/sources_non_forked/git-aware-prompt
source $GITAWAREPROMPT/main.sh
export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
export PROMPT_DIRTRIM=2

# rbenv
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export VAGRANT_DEFAULT_PROVIDER=parallels
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

complete -C aws_completer aws

alias ll='ls -alh'

direct_docker_host () {
  pushd /Users/bholt/Developer/dwolla-docker-vm > /dev/null
  export DOCKER_HOST="tcp://`vagrant ssh-config | sed -n "s/[ ]*HostName[ ]*//gp"`:2375"
  popd > /dev/null
  echo DOCKER_HOST=$DOCKER_HOST
}

docker_rmi_untagged () {
  docker rmi $(docker images | awk '/^<none>/{print $3}')
}

docker_rm_exited () {
  docker rm $(docker ps -q -f status=exited)
}

chuck () {
  export HTTP_PROXY=http://127.0.0.1:8888
  export HTTPS_PROXY=http://127.0.0.1:8888
}

dechuck() {
  unset HTTP_PROXY
  unset HTTPS_PROXY
}

if [ -e local.sh ]; then
    . local.sh
fi
