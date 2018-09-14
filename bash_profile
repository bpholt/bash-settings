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
export EC2_USERNAME=ec2-user

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

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

ssh_to_instance() {
    ssh -o StrictHostKeyChecking=no ${EC2_USERNAME}@$(aws ec2 describe-instances --instance-ids $1 --region us-west-2  | jq -r '.Reservations[].Instances[].PrivateIpAddress' | grep -v -e '^$')
}

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add -K;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

if [ -e ~/.bash/local.sh ]; then
    . ~/.bash/local.sh
fi

if [ -e ~/.nvm ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
fi
