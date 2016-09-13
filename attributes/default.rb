#
# Cookbook Name:: marchefdk
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# this is only used in users.rb, which is for use with chef-zero,
# and should be supplied on cmdline; this is just a dummy default value
default['marchefdk']['basedir'] = '/site/marchex-chef'

default['marchefdk']['repo_list'] = {
  'marchex-chef/marchex-chef-generator' => '',
  'marchex-chef/mchx_chef_helpers'      => 'cookbooks',
  'marchex-chef/marchefdk'              => 'cookbooks',
  'marchex-chef/tests_mchx_dk'          => 'tests'
}

default['marchefdk']['package_list'] = []
if node['platform_family'] == 'debian'
  default['marchefdk']['package_list'] += %w(
    vagrant
    virtualbox
  )
end

default['marchefdk']['chef_gem_list'] = %w(
  tty-prompt
  chef-vault-testfixtures
  chef-api
  vagrant-omnibus
  vagrant-cachier
  inspec
)
