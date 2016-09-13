#!/bin/bash

set -e

RED='\033[1;31m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m'
myshell=$(basename $SHELL)

echo_out() {
    local msg=$1
    printf "\n\n${RED}### mchx_dk:${NC} ${YELLOW}${msg}${NC}\n"
}

fix_prereqs() {
    echo_out 'check prereqs'
    if [[ ! -x $(which curl) ]]; then
        if [[ -x $(which apt-get) ]]; then
            sudo apt-get update
            sudo apt-get install -y curl
        else
            echo "Please install `curl` before continuing"
            exit -1
        fi
    fi
}

install_chefdk() {
    echo_out 'install ChefDK'
    requested_version=latest # x.y.z for specific version
    install_version=$(chef --version 2>/dev/null| grep '^Chef Development Kit Version' | perl -pe 's|^.+?: ([\d.]+).*$|$1|')
    # XXX dynamically supply p / pv / m?  or does it matter for metadata?
    avail_version=$(curl -sL 'https://omnitruck.chef.io/stable/chefdk/metadata?p=ubuntu&pv=12.04&m=x86_64&v='$requested_version | grep ^url | perl -pe 's|^.+/chefdk_([\d.]+).+$|$1|')
    if [[ ! "$install_version" || ("$install_version" != "$avail_version") ]]; then
        curl --retry 5 -sL https://omnitruck.chef.io/install.sh | sudo bash -s -- -c stable -P chefdk -v $requested_version
    fi
}

update_env() {
    echo_out 'add chefdk to environment'
    eval "$(chef shell-init ${myshell})"
}

create_dirs() {
    echo_out 'create base directory structure'
    printf "${YELLOW}Where do you want to install your development environment?${NC} [${BLUE}${HOME}${NC}] "
    read
    if [[ -z "$REPLY" ]]; then
        basedir=$HOME
    else
        basedir=$REPLY
    fi
    basedir="${basedir}/marchex-chef"
    mkdir -p ${basedir}/cookbooks
    mkdir -p ${basedir}/tests
    cd ${basedir}
}

get_repo() {
    echo_out 'get marchefdk repo so we can finish setting up our environment'
    if [[ -d marchefdk ]]; then
        cd marchefdk
        # the cookbook should self-update, but let's pull it ourselves just in case
        git pull origin master
    else
        git clone https://github.marchex.com/marchex-chef/marchefdk
        cd marchefdk
    fi
}

knife_rb() {
    echo_out 'set up environment'
    mkdir -p ${basedir}/.chef
    local knifefile="${basedir}/.chef/knife.rb"

    client_key=$(grep 'client_key' $HOME/.chef/knife.rb 2>/dev/null | perl -pe 's/\s*client_key\s+"([^"]+?)"/$1/')
    if [[ -z "${client_key}" ]]; then
        client_key="${basedir}/.chef/${USER}.pem"
    fi

    printf "${YELLOW}Where is your Chef client key?${NC} [${BLUE}${client_key}${NC}] "
    read
    if [[ ! -z "$REPLY" ]]; then
        client_key=$REPLY
    fi

    cat << EOF > $knifefile
home =                  "#{ENV['HOME']}"
current_dir =           File.dirname(__FILE__)
log_level               :info
log_location            STDOUT
node_name               "${USER}"
client_key              "${client_key}"
chef_server_url         "https://chef.marchex.com/organizations/marchex"
cookbook_path           ["#{current_dir}/../cookbooks"]
knife[:vault_mode] =    'client'
EOF
}

run_chef_client() {
    echo_out 'run recipes to finish setup'
    sudo chef-client -z recipes/installs.rb
}

finish() {
    echo_out 'installation complete'
    printf "${BLUE}Please add these lines to your .bash_profile (if you don't have them already):${NC}\n"
    echo "eval \"\$(chef shell-init ${myshell})\""
    echo ""
    printf "${BLUE}Please copy your client key file to ${client_key} (if you haven't already)${NC}\n"
}

fix_prereqs
install_chefdk
update_env
create_dirs
get_repo
knife_rb
run_chef_client
finish



#delivery token
#github token
#copy hosted chef client key to on-prem

