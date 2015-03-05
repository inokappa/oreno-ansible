require 'spec_helper'

describe file('/etc/monit.conf') do
  it { should be_file }
  it { should be_mode 600 }
end

packages = [
  'monit',
  'htop',
]
packages.each do |pkg|
  describe package pkg do
    it { should be_installed }
  end
end
