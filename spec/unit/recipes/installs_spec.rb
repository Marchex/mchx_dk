#
# Cookbook Name:: marchefdk
# Spec:: installs
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

  context 'installs' do
    packages = %w(
      vagrant
      virtualbox
    )
    gems = %w(
      tty-prompt
      chef-vault-testfixtures
      chef-api
      vagrant-omnibus
      vagrant-cachier
      inspec
    )
    repos = %w(
      marchefdk
      marchex-chef-generator
    )

    packages.sort.each do |pkg|
      it "package #{pkg}" do
        chef_run.converge(described_recipe)
        expect(chef_run).to install_package pkg
      end
    end

    gems.sort.each do |gem|
      it "gem #{gem}" do
        chef_run.converge(described_recipe)
        expect(chef_run).to install_chef_gem gem
      end
    end

    repos.sort.each do |repo|
      it "repo #{repo}" do
        chef_run.converge(described_recipe)
        expect(chef_run).to sync_git(repo).with(
          'destination' => ENV['HOME'] + "/marchex-chef/" + repo
        )
      end
    end
  end

  it 'fetches repos' do
    chef_run.converge(described_recipe)
  end
end

describe 'marchefdk::installs' do
  context 'on ubuntu 12.04' do
    test_platform(platform: 'ubuntu', version: '12.04')
  end

  context 'on ubuntu 16.04' do
    test_platform(platform: 'ubuntu', version: '16.04')
  end

  context 'on centos 6.6' do
    test_platform(platform: 'centos', version: '6.6')
  end

  context 'on centos 7.0' do
    test_platform(platform: 'centos', version: '7.0')
  end
end
