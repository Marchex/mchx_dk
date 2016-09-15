#!/bin/bash

set -e

RED='\033[1;31m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m'
myshell=$(basename $SHELL)

echo_msg() {
    local msg=$1
    printf "$YELLOW$msg$NC\n"
}

echo_head() {
    local msg=$1
    printf "\n$RED### mchx_dk:$NC "
    echo_msg "$msg"
}

fix_prereqs() {
    echo_head 'check prereqs'
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
    echo_head 'install ChefDK'
    requested_channel=stable
    requested_version=latest # x.y.z for specific version
    install_version=$(chef --version 2>/dev/null| grep '^Chef Development Kit Version' | perl -pe 's|^.+?: ([\d.]+).*$|$1|')
    # XXX dynamically supply p / pv / m?  or does it matter for metadata?
    avail_version=$(curl -sL 'https://omnitruck.chef.io/'$requested_channel'/chefdk/metadata?p=ubuntu&pv=12.04&m=x86_64&v='$requested_version | grep ^url | perl -pe 's|^.+/chefdk_([\d.]+).+$|$1|')
    if [[ ! "$install_version" || ("$install_version" != "$avail_version") ]]; then
        curl --retry 5 -sL https://omnitruck.chef.io/install.sh | sudo bash -s -- -c $requested_channel -P chefdk -v $requested_version
    fi
}

update_env() {
    echo_head 'add chefdk to environment'
    eval "$(chef shell-init $myshell)"
}

create_dirs() {
    echo_head 'create base directory structure'
    basedir=''
    if [[ -f "$HOME/.marchex-chef-basedir" ]]; then
        basedir=$(cat $HOME/.marchex-chef-basedir)
    fi
    if [[ ! -z "$basedir" && -e "$basedir" ]]; then
        echo_msg "Using '$basedir'"
        cd "$basedir"
        return
    fi

    printf "${YELLOW}Where do you want to install your development environment?$NC [$BLUE$HOME$NC] "
    read
    if [[ -z "$REPLY" ]]; then
        basedir="$HOME"
    else
        basedir="$REPLY"
    fi
    basedir="$basedir/marchex-chef"
    echo "$basedir" > "$HOME/.marchex-chef-basedir"
    mkdir -p "$basedir/cookbooks"
    mkdir -p "$basedir/tests"
    cd "$basedir"
}

get_repo() {
    echo_head 'get mchx_dk repo so we can finish setting up our environment'
    echo_msg "checking out code to $basedir/cookbooks/mchx_dk"
    if [[ -d "$basedir/cookbooks/mchx_dk" ]]; then
        cd "$basedir/cookbooks/mchx_dk"
        # the cookbook should self-update, but let's pull it ourselves just in case
        git pull --ff-only origin master
        cd "$basedir"
    else
        cd "$basedir/cookbooks"
        git clone https://github.marchex.com/marchex-chef/mchx_dk
        cd "$basedir"
    fi
}

get_client_key() {
    echo_head 'getting client key'
    client_key=$(grep 'client_key' "${basedir}/.chef/knife.rb" 2>/dev/null | perl -pe 's/\s*client_key\s+"([^"]+?)"/$1/')
    if [[ -z "$client_key" ]]; then
        client_key=$(grep 'client_key' "$HOME/.chef/knife.rb" 2>/dev/null | perl -pe 's/\s*client_key\s+"([^"]+?)"/$1/')
    fi
    if [[ -z "$client_key" ]]; then
        client_key="$basedir/.chef/$USER.pem"
    fi

    printf "${YELLOW}Where is your Chef client key?$NC [$BLUE$client_key$NC] "
    read
    if [[ ! -z "$REPLY" ]]; then
        client_key=$REPLY
    fi

    echo "$client_key" > "$HOME/.marchex-chef-client-key"
}

run_chef_client() {
    echo_head 'run recipes to finish setup'
    "$basedir/cookbooks/mchx_dk/run_cookbook.sh"
}

finish() {
    echo_head 'installation complete'
    printf "${YELLOW}If you haven't already:$NC\n"
    if [[ ! -z "$client_key" ]]; then
        printf "  * ${BLUE}Copy your client key file to $client_key$NC\n"
    fi
    printf "  * ${BLUE}Add this line to your .bash_profile or equivalent,$NC\n"
    printf "    ${BLUE}and$NC ${RED}execute it in your shell now:$NC\n"
    echo   "    eval \"\$(chef shell-init $myshell)\""
    echo ""
    echo "Done."
}

# do things
fix_prereqs
install_chefdk
update_env
create_dirs
get_repo
get_client_key
run_chef_client
finish
