#
# Cookbook Name:: mchx_dk
# Spec:: chef_dk
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

  it 'installs latest chef_dk' do
    chef_run.converge(described_recipe)
    expect(chef_run).to install_chef_dk 'MarChefDK'
  end
end

describe 'mchx_dk::chef_dk' do
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
