#
# Cookbook Name:: mchx_dk
# Recipe:: chef_dk
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# normally, chef_dk will be installed by install.sh, but this recipe will do it too.

chef_dk 'MarChefDK' do
  action :install
end
