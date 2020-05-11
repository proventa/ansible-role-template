[![Build Status](https://travis-ci.com/yanehi/ansible-role-template.svg?branch=master)](https://travis-ci.org/yanehi/ansible-role-template)

# ansible-role-template
Template for custom Ansible roles.

## Technical Requirements

### Pre-requirements for Linux

* install ansible

```bash
sudo apt-get update
sudo apt-get install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-get install ansible
```

* check if python > v2 is installed

```bash
python --version
```

* install vagrant for local vm provisioning

```bash
sudo apt-get install virtualbox
sudo apt-get install vagrant
```

* install vagrant cachier plugin

```bash
vagrant plugin install vagrant-cachier
```

## Ansible files and folder structure

* ansible folder strucutre

```
site.yml                  # master playbook
servers.yml               # enable specific roles for hosts
ansible-role-template/    # this hierarchy represents a "role"
    /defaults             # define variables for usage in tasks 
    /handlers             # define "handlers" for start, stop and reload processes
    /meta                 # some metadata for the ansible galaxy
    /molecule             # molecule testing in tavis-ci
    /tasks                # tasks that will be executed on the servers
```

* order of file execution

  * site.yml
  * dbservers.yml (based on hosts) 
  * tasks
    * main.yml
      * sample_playbooks.yml
  * handlers
    * main.yml

## Running playbooks

* clone repo and configure your hosts

```bash
git clone git@github.com:yanehi/ansible-role-template.git
cd ansible-role-template
```

* start virtual machine with centos7

```bash
vagrant up
```

* copy the ssh-key from the ansible host to the required hosts
  * `cat ~/.ssh/id_rsa.pub`

* on the hosts
  * `mkdir ~/.ssh`
  * `touch ~/.ssh/authorized_keys && chmod 600 authorized_keys`
  * copy your ansible hosts ssh-key to the authorized_keys file on each host

* check the connection form the ansible host to the other hosts
  * `ansible -m ping all`

* execute your ansible playbook
  * `ansible-playbook <path to folder with role>/site.yml`

## Local linter

* before pushing to travis-ci run `yamllint` and `ansible-lint` locally over your ansible role
* requirements:
  * currently working only with linux
  * yamllint and ansible-lint are installed

```bash
./local_role_linter.sh <path to local ansible role repository>
```
