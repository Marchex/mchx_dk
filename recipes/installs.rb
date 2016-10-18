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
