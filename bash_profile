export GITAWAREPROMPT=~/.bash/git-aware-prompt
source $GITAWAREPROMPT/main.sh
export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
export PROMPT_DIRTRIM=2

# rbenv
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export VAGRANT_DEFAULT_PROVIDER=parallels

complete -C aws_completer aws

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

