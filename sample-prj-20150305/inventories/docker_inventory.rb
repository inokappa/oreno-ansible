#!/usr/bin/env ruby

require 'docker'
require 'json'

docker_host = "192.168.59.103" # boot2docker 
target_host_name = "ansible_"
target_user_name = "ansible"
target_user_pass = "ansible"

containers = Docker::Container.all(:running => true)
targets = containers.select do |con|
  con.info['Names'][0].include? target_host_name
end

target = {}

targets.map do |t|
  t.info['Ports'].each do |p|
    target.merge!({ t.info['Names'][0].gsub("/","") => { "ansible_ssh_host" => docker_host, "ansible_ssh_port" =>  p['PublicPort'], "ansible_ssh_user" => target_user_name, "ansible_ssh_pass" => target_user_pass }})
  end
end

puts JSON.generate(target)
