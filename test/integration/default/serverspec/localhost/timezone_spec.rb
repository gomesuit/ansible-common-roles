require 'rubygems'
require 'spec_helper'

#describe package('ntp'), :if => os[:family] == 'redhat' do
#  it { should be_installed }
#end

#describe service('ntpd'), :if => os[:family] == 'redhat' do
#  it { should be_enabled }
#  it { should be_running }
#end

describe command('date'), :if => os[:family] == 'redhat' do
  its(:stdout) { should match /JST/ }
end
