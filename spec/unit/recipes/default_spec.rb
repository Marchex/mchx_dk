#
# Cookbook Name:: mchx_dk
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'mchx_dk::default' do
  context 'When all attributes are default, on Ubuntu 12.04' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04')
      stub_command("wc -l /tmp/mchx_dk_virtualbox_packages_installed").and_return(true)
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
