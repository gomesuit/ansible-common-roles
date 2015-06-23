require 'rubygems'
require 'spec_helper'

describe package('serverspec') do
  it { should be_installed.by('gem') }
end

