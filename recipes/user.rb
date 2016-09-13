#
# Cookbook Name:: marchefdk
# Recipe:: user
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

basedir = node['marchefdk']['basedir']
node['marchefdk']['repo_list'].each do |repo, dir|
  git repo do
    repository "https://github.marchex.com/#{repo}"
    destination "#{basedir}/#{dir}/" + File.basename(repo)
    user ENV['USER']
    action :sync
  end
end
