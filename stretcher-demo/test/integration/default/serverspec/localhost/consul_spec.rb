require 'spec_helper'

describe user('consul') do
  it { should exist }
  it { should belong_to_group 'consul' }
  it { should have_login_shell '/sbin/nologin' }
end

files = {
  '/usr/local/bin/consul' => '755',
  '/usr/local/bin/stretcher' => '755',
  '/etc/init.d/consul' => '755',
  '/etc/consul.d/default.json' => '644',
}
files.each do |f,mode|
  describe file(f) do
    it { should be_file }
    it { should be_mode mode }
  end
end

dirs = [ 
  '/opt/consul', 
  '/opt/consul-ui', 
  '/opt/consul-ui/static', 
]
dirs.each do |dir|
  describe file(dir) do
    it { should be_directory }
    it { should be_owned_by 'consul' }
    it { should be_grouped_into 'consul' }
  end
end

packages = [
  'tar',
  'wget',
  'vim-enhanced',
  'rsync',
]
packages.each do |pkg|
  describe package pkg do
    it { should be_installed }
  end
end
