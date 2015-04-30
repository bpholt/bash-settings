#!/bin/bash

pushd ~/.bash

mkdir -p sources_non_forked
git clone git://github.com/jimeh/git-aware-prompt.git sources_non_forked/git-aware-prompt

if [ -f ~/.bash_profile ]; then
    mv ~/.bash_profile ~/.bash_profile.bak
fi
ln -s ~/.bash/bash_profile ~/.bash_profile

if [ -f ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc.bak
fi
ln -s ~/.bash/bashrc ~/.bashrc

