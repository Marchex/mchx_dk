#!/bin/bash

set -e

# XXX check if it is installed, prompt to decide whether to install, prompt for version?
echo '### marchefdk: install ChefDK'
# -v x.y.z for specific version
curl --retry 5 -sL https://omnitruck.chef.io/install.sh | sudo bash -s -- -c current -P chefdk

# XXX check if it is environment already, prompt to decide whether to add to .bash_profile etc.
echo '### marchefdk: add chefdk to environment'
# XXX will this work without a path to `chef`?
eval "$(chef shell-init bash)"

# XXX prompt for options?
echo '### marchefdk: create base directory structure'
mkdir -p $HOME/marchex-chef/cookbooks
mkdir -p $HOME/marchex-chef/tests
cd $HOME/marchex-chef

echo '### marchefdk: get marchefdk repo so we can finish setting up our environment'
if [[ -d marchefdk ]]; then
    cd marchefdk
    git pull origin master
else
    git clone https://github.marchex.com/marchex-chef/marchefdk
    cd marchefdk
fi

sudo chef-client -z recipes/installs.rb
