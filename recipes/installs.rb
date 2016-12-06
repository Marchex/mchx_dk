#
# Cookbook Name:: mchx_dk
# Recipe:: installs
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

if node['platform_family'] == 'debian'
  # unfortunately necessary sometimes
  execute 'apt-get update'
end

node['mchx_dk']['package_list'].each do |pkg|
  package pkg
end

if node['platform'] == 'ubuntu'
  # we don't want to do any messing with virtualbox if it is already installed
  bash 'virtualbox_packages_installed' do
    # ask dpkg for any packages matching "virtualbox"
    # it has to be installed with no errors ("ii ") and match "virtualbox" or "virtualbox-\d+.\d+"
    code <<-EOH
      echo -n $(dpkg-query -l virtualbox* | grep '^ii  virtualbox(-[0-9]+\.[0-9]+)? ') > /tmp/mchx_dk_virtualbox_packages_installed
      EOH
  end

  # If 12.04, then vbox 4x (if not ubuntu, you're on your own)
  apt_repository 'virtualbox-4x' do
    not_if 'wc -l /tmp/mchx_dk_virtualbox_packages_installed'
    only_if { node['platform_version'] == '12.04' }
    uri 'http://download.virtualbox.org/virtualbox/debian'
    distribution 'trusty'
    components ['contrib']
    key 'http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc'
  end

  package 'virtualbox-4.3' do
    not_if 'wc -l /tmp/mchx_dk_virtualbox_packages_installed'
    only_if { node['platform_version'] == '12.04' }
  end

  # If 16.04, then vbox 5x
  apt_repository 'virtualbox-5x' do
    not_if 'wc -l /tmp/mchx_dk_virtualbox_packages_installed'
    only_if { node['platform_version'] == '16.04' }
    uri 'http://download.virtualbox.org/virtualbox/debian'
    distribution 'xenial'
    components ['contrib']
    key 'http://download.virtualbox.org/virtualbox/debian/oracle_vbox_2016.asc'
  end

  package 'virtualbox-5.0' do
    not_if 'wc -l /tmp/mchx_dk_virtualbox_packages_installed'
    only_if { node['platform_version'] == '16.04' }
  end
end

node['mchx_dk']['chef_gem_list'].each do |gem|
  chef_gem gem do
    compile_time false
  end
end

chef_gem 'marchex_helpers' do
  clear_sources true
  source 'http://rubygems.sea.marchex.com/'
  version '>= 0.1.17'
  compile_time false
end
