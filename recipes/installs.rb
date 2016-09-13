#
# Cookbook Name:: marchefdk
# Recipe:: packages
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

node['marchefdk']['package_list'].each do |pkg|
  package pkg
end

node['marchefdk']['chef_gem_list'].each do |gem|
  chef_gem gem do
    compile_time true if Chef::Resource::ChefGem.instance_methods(false).include?(:compile_time)
  end
end

%w(marchex-chef-generator marchefdk).each do |repo|
  git repo do
    repository "https://github.marchex.com/marchex-chef/#{repo}"
    destination "#{ENV['HOME']}/marchex-chef/#{repo}"
    user ENV['USER']
    action :sync
  end
end
