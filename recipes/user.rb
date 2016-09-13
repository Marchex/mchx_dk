#
# Cookbook Name:: mchx_dk
# Recipe:: user
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

basedir = node['mchx_dk']['basedir']
node['mchx_dk']['repo_list'].each do |repo, dir|
  git repo do
    repository "https://github.marchex.com/#{repo}"
    destination "#{basedir}/#{dir}/" + File.basename(repo)
    user ENV['USER']
    action :sync
  end
end
