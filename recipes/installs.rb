#
# Cookbook Name:: marchefdk
# Recipe:: packages
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

packages = %w(vagrant virtualbox)
packages.each do |pkg|
  package pkg
end

gems = %w(
  tty-prompt
  chef-vault-testfixtures
  chef-api
  vagrant-omnibus
  vagrant-cachier
)
gems.each do |gem|
  chef_gem gem do
    compile_time true if Chef::Resource::ChefGem.instance_methods(false).include?(:compile_time)
  end
end
