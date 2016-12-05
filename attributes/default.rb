#
# Cookbook Name:: mchx_dk
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# these are only used in users.rb, which is for use with chef-zero,
# and should be supplied on cmdline; these are just default values
# intended to be overwritten
default['mchx_dk']['basedir'] = '/site/marchex-chef'
default['mchx_dk']['user'] = ENV['USER']
default['mchx_dk']['client_key'] = "/site/marchex-chef/.chef/#{ENV['USER']}.pem"

default['mchx_dk']['repo_list'] = {
  'marchex-chef/marchex-chef-generator' => '',
  'marchex-chef/mchx_chef_helpers'      => 'cookbooks',
  'marchex-chef/mchx_dk'                => 'cookbooks',
  'marchex-chef/tests_mchx_dk'          => 'tests'
}

default['mchx_dk']['package_list'] = []
if node['platform_family'] == 'debian'
  default['mchx_dk']['package_list'] += %w(
    vagrant
    curl
    git
  )
end

# marchex_helpers is defined directly in installs.rb
default['mchx_dk']['chef_gem_list'] = [
  'tty-prompt',               # marchex-chef-generator
  'chef-vault-testfixtures',  # chefspec tests for vaults
  'chef-api',                 # marchex-chef-generator
  'vagrant-omnibus',          # test kitchen
  'vagrant-cachier',          # test kitchen
  'inspec',                   # inspec
  'octokit'                   # talk to GitHub API (mostly marchex-chef-generator)
]
