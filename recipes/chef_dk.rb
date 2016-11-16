#
# Cookbook Name:: mchx_dk
# Recipe:: chef_dk
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# normally, chef_dk will be installed by install.sh, but this recipe will do it too.

# chef_dk resource reinstalls the DK every time it is run.  this bash script
# checks the version of the installed and the available versions, and outputs the
# result to a temp file, which the chef_dk resource has a guard on.
# there is a small potential race condition, for the temp file.
# and it picks a specific OS/version to ask about, which will break some day,
# when the DK for that version doesn't match what you want to install for a
# given machine.
bash 'check_version' do
  code <<-EOH
    install_version=$(chef --version 2>/dev/null | grep '^Chef Development Kit Version' | /usr/bin/perl -pe 's|^.+?: ([\\d.]+).*$|$1|;')
    avail_version=$(curl -sL 'https://omnitruck.chef.io/stable/chefdk/metadata?p=ubuntu&pv=12.04&m=x86_64&v=latest' | grep ^url | perl -pe 's|^.+/chefdk_([\\d.]+).+$|$1|')
    if [[ ! "$install_version" || ("$install_version" != "$avail_version") ]]; then
        echo false > /tmp/chefdk_uptodate
    else
        echo true > /tmp/chefdk_uptodate
    fi
    EOH
end

chef_dk 'MarChefDK' do
  action :install
  not_if 'grep true /tmp/chefdk_uptodate'
end
