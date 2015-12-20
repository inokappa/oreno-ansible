## test-kitchen + kitchen-vagrant + kitchen-ansible + Serverspec sample

### How to use

1. bundle install
2. kitchen create
3. kitchen converge
4. kitchen verify

## More...

### Write Playbook

~~~
mkdir -p roles/newrole/{tasks,vars,files}
vim roles/newrole/tasks/main.yml
~~~

for example.

~~~
- name: install the latest version of foo
  yum: name=foo state=latest
~~~

### Write Playbook wrapper YAML

~~~
vim newrole.yml
~~~

for example.

~~~
- hosts: all
  sudo: yes
  roles:
    - newrole
~~~

### Write Spec wrapper YAML

~~~
vim test/integration/default.yml
~~~

for example.

~~~
---
- name: wrapper playbook for kitchen testing "newrole"
  hosts: localhost
  roles:
    - newrole
~~~

### Write Spec file

~~~
vim test/integration/default/serverspec/localhost/newrole_spec.rb
~~~

for example.

~~~
require 'spec_helper'

packages = [
  'foo',
]
packages.each do |pkg|
  describe package pkg do
    it { should be_installed }
  end
end
~~~
