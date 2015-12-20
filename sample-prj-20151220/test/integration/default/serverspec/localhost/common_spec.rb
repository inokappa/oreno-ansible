require 'spec_helper'
#require 'serverspec'
#
#set :backend, :ssh
#
#options = Net::SSH::Config.for(host)
#options[:host_name] = ENV['KITCHEN_HOSTNAME']
#options[:user]      = ENV['KITCHEN_USERNAME']
#options[:port]      = ENV['KITCHEN_PORT']
#options[:keys]      = ENV['KITCHEN_SSH_KEY']
#
#set :host,        options[:host_name]
#set :ssh_options, options
#set :env, :LANG => 'C', :LC_ALL => 'C'

#files = [
#  "epel.repo",
#  "rpmforge.repo",
#]
#
#files.each do |file|
#  describe file("/etc/yum.repos.d/#{file}") do
#    it { should be_file }
#    it { should be_mode 600 }
#  end
#end
#
#packages = [
#  "monit",
#  "htop",
#]
#packages.each do |pkg|
#  describe package pkg do
#    it { should be_installed }
#  end
#end

describe file('/tmp/httpd.conf') do
  it { should be_file }
end
