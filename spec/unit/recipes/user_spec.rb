#
# Cookbook Name:: mchx_dk
# Spec:: user
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

def test_platform(attrs)
  let(:chef_run) do
    if attrs.nil?
      ChefSpec::ServerRunner.new
    else
      ChefSpec::SoloRunner.new(attrs)
    end
  end

  it 'converges successfully' do
    chef_run.converge(described_recipe)
    expect { chef_run }.to_not raise_error
  end

  it 'installs repos' do
    chef_run.converge(described_recipe)
    chef_run.node['mchx_dk']['repo_list'].sort.each do |repo, dir|
      expect(chef_run).to sync_git(repo).with(
        'destination' => chef_run.node['mchx_dk']['basedir'] + "/#{dir}/" + File.basename(repo),
        'checkout_branch' => 'master',
        'user' => chef_run.node['mchx_dk']['user']
      )
    end
  end

  it 'creates dirs' do
    chef_run.converge(described_recipe)
    basedir = chef_run.node['mchx_dk']['basedir']
    dk_user = chef_run.node['mchx_dk']['user']
    expect(chef_run).to create_directory(basedir).with('owner' => dk_user)
    expect(chef_run).to create_directory("#{basedir}/cookbooks").with('owner' => dk_user)
    expect(chef_run).to create_directory("#{basedir}/tests").with('owner' => dk_user)
    expect(chef_run).to create_directory("#{basedir}/.chef").with('owner' => dk_user)
  end

  it 'installs conf files' do
    chef_run.converge(described_recipe)
    basedir = chef_run.node['mchx_dk']['basedir']
    dk_user = chef_run.node['mchx_dk']['user']
    expect(chef_run).to create_template_if_missing("#{basedir}/.chef/knife.rb").with(
      'source' => 'knife.rb.erb',
      'owner'  => dk_user
    )
  end
end

describe 'mchx_dk::user' do
  context 'on ubuntu 12.04' do
    test_platform(platform: 'ubuntu', version: '12.04')
  end
end
