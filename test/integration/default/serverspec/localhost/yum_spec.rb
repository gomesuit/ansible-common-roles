require 'rubygems'
require 'spec_helper'

describe package('vim-enhanced'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('wget'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('git'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

