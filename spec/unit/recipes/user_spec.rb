#
# Cookbook Name:: marchefdk
# Spec:: user
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength

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
    chef_run.node['marchefdk']['repo_list'].sort.each do |repo, dir|
      expect(chef_run).to sync_git(repo).with(
        'destination' => chef_run.node['marchefdk']['basedir'] + "/#{dir}/" + File.basename(repo)
      )
    end
  end
end

describe 'marchefdk::user' do
  context 'on ubuntu 12.04' do
    test_platform(platform: 'ubuntu', version: '12.04')
  end
end
