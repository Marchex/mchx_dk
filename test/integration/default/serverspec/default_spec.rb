require 'spec_helper'

describe 'mchx_dk::default' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  it 'does something' do
    # TODO: replace with real tests
    skip 'Replace this with meaningful tests'
  end

  # Common examples
  # describe package('tmux') do
  #  it { should be_installed }
  # end

  # describe file('/tmp/my_awesome_directory') do
  #  it { should be_directory }
  #  it { should be_owned_by 'root' }
  #  it { should be_grouped_into 'root' }
  #  it { should be_mode 640 }
  # end

  # describe file('/tmp/my_awesome_file') do
  #  it { should be_file }
  #  it { should be_owned_by 'root' }
  #  it { should be_grouped_into 'root' }
  #  it { should be_mode 400 }
  #  # Supports all Rspec matchers, see: https://www.relishapp.com/rspec/rspec-expectations/v/3-3/docs/built-in-matchers
  #  its(:content) { should start_with('# First line of file') }
  #  its(:content) { should include 'my_content' }
  #  its(:content) { should_not include 'unexpected string' }
  #  its(:content) { should match /^my\s+awesome\s+regex$/ }
  #  its(:content) { should end_with("# Last line of file with trailing newline\n") }
  # end
end
