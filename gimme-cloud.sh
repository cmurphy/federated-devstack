#!/usr/bin/env bash

set -eux

# TODO: remove after https://github.com/ansible/ansible/pull/20609 is addressed and released
if [ -d $HOME/ansible ] ; then
  pushd $HOME/ansible
  git pull
  popd
else
  git clone https://github.com/cmurphy/ansible $HOME/ansible
fi
sudo pip install $HOME/ansible

ansible-playbook -vvvv -i "localhost," -c local playbooks/install-devstack.yml
# TODO: remove when requirements/upper-constraints.txt is updated
sudo pip install -U --no-deps python-openstackclient
source $HOME/devstack/accrc/admin/admin
export OS_IDENTITY_API_VERSION=3
ansible-playbook -vvvv -i "localhost," -c local playbooks/configure-federation.yml
