#
# Cookbook Name:: mchx_dk
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

  it 'updates apt' do
    chef_run.converge(described_recipe)
    if chef_run.node['platform_family'] == 'debian'
      expect(chef_run).to run_execute 'apt-get update'
    end
  end

  it 'installs packages' do
    chef_run.converge(described_recipe)
    chef_run.node['mchx_dk']['package_list'].sort.each do |pkg|
      expect(chef_run).to install_package pkg
    end
  end

  it 'installs gems' do
    chef_run.converge(described_recipe)
    chef_run.node['mchx_dk']['chef_gem_list'].sort.each do |chef_gem|
      expect(chef_run).to install_chef_gem chef_gem
    end
  end

  it 'installs custom gems' do
    chef_run.converge(described_recipe)
    %w(octokit marchex_helpers).sort.each do |chef_gem|
      expect(chef_run).to install_chef_gem(chef_gem).with(
        'source'        => 'http://rubygems.sea.marchex.com/',
        'clear_sources' => true
      )
    end
  end
end

describe 'mchx_dk::installs' do
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
