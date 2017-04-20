#
# Cookbook Name:: mchx_dk
# Recipe:: user
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

basedir       = node['mchx_dk']['basedir']
dk_user       = node['mchx_dk']['user']
dk_client_key = node['mchx_dk']['client_key']

directory basedir do
  owner dk_user
end

directory "#{basedir}/cookbooks" do
  owner dk_user
end

directory "#{basedir}/tests" do
  owner dk_user
end

directory "#{basedir}/.chef" do
  owner dk_user
end

template "#{basedir}/.chef/knife.rb" do
  source "knife.rb.erb"
  owner dk_user
  variables(
    :dk_user       => dk_user,
    :dk_client_key => dk_client_key
  )
  action :create_if_missing
end

node['mchx_dk']['repo_list'].each do |repo, dir|
  git repo do
    repository "https://github.marchex.com/#{repo}"
    destination "#{basedir}/#{dir}/" + File.basename(repo)
    checkout_branch 'master'
    enable_checkout false
    user dk_user
    action :sync
  end
end

# clean up dir ownnership
directory "#{ENV['HOME']}/.chef" do
  owner dk_user
  recursive true
end

directory "#{ENV['HOME']}/.chefdk" do
  owner dk_user
  recursive true
end

directory "#{ENV['HOME']}/.berkshelf" do
  owner dk_user
  recursive true
end
