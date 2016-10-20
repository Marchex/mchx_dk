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
#
# If 12.04, then vbox 4x (if not ubuntu, you're on your own)
apt_repository 'virtualbox-4x' do
  only_if do node['platform'].eql?('ubuntu') and node['platform_version'] == '12.04' end
  uri 'http://download.virtualbox.org/virtualbox/debian'
  distribution 'trusty'
  components ['contrib']
  key 'http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc'
end

package 'virtualbox-4.3' do
  only_if do node['platform'] == 'ubuntu' && node['platform_version'] == '12.04' end
end
#
# If 16.04, then vbox 5x
apt_repository 'virtualbox-5x' do
  only_if do node['platform'].eql?('ubuntu') and node['platform_version'] == '16.04' end
  uri 'http://download.virtualbox.org/virtualbox/debian'
  distribution 'xenial'
  components ['contrib']
  key 'http://download.virtualbox.org/virtualbox/debian/oracle_vbox_2016.asc'
end

package 'virtualbox-5.0' do
  only_if do node['platform'] == 'ubuntu' && node['platform_version'] == '16.04' end
end

node['mchx_dk']['chef_gem_list'].each do |gem|
  chef_gem gem do
    compile_time false
  end
end

chef_gem 'octokit' do
  clear_sources true
  source 'http://rubygems.sea.marchex.com/'
  version '4.3.1.pre1'
  compile_time false
end

chef_gem 'marchex_helpers' do
  clear_sources true
  source 'http://rubygems.sea.marchex.com/'
  version '>= 0.1.17'
  compile_time false
end
