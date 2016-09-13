#
# Cookbook Name:: marchefdk
# Recipe:: installs
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# unfortunately necessary sometimes
execute 'apt-get update' if node['platform_family'] == 'debian'

if %w(debian rhel).include? node['platform_family']
  node['marchefdk']['package_list'].each do |pkg|
    package pkg
  end
end

node['marchefdk']['chef_gem_list'].each do |gem|
  chef_gem gem do
    compile_time false
  end
end
