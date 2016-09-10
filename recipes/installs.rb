#
# Cookbook Name:: marchefdk
# Recipe:: packages
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

node.default['marchefdk']['package_list'].each do |pkg|
  package pkg
end

node.default['marchefdk']['chef_gem_list'].each do |gem|
  chef_gem gem do
    compile_time true if Chef::Resource::ChefGem.instance_methods(false).include?(:compile_time)
  end
end

git 'marchex-chef-generator' do
  repository 'git@github.marchex.com:marchex-chef/marchex-chef-generator'
  destination "#{ENV['HOME']}/marchex-chef/marchex-chef-generator"
  action :sync
end
