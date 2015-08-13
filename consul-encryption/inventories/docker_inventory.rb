#!/usr/bin/env ruby

require 'docker'
require 'json'

# You should comment out either.
# docker_host = "192.168.59.103" # If you're using a boot2docker.
docker_host = "127.0.0.1"      # If you're using localhost docker.

#
target_host_name = "consul-"
target_user_name = "ansible"
target_user_pass = "ansible"

containers = Docker::Container.all(:running => true)
targets = containers.select do |con|
  con.info['Names'][0].include? target_host_name
end

target = {}

targets.map do |t|
  t.info['Ports'].each do |p|
    if p['PrivatePort']  == 22
      target.merge!({ t.info['Names'][0].gsub("/","") => { "ansible_ssh_host" => docker_host, "ansible_ssh_port" =>  p['PublicPort'], "ansible_ssh_user" => target_user_name, "ansible_ssh_pass" => target_user_pass }})
    end
  end
end

puts JSON.generate(target)
