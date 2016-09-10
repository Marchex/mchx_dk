#
# Cookbook Name:: marchefdk
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

default['marchefdk']['package_list'] = %w(
  vagrant
  virtualbox
)

default['marchefdk']['chef_gem_list'] = %w(
  tty-prompt
  chef-vault-testfixtures
  chef-api
  vagrant-omnibus
  vagrant-cachier
)
