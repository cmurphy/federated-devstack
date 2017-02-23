#!/usr/bin/env bash

set -eux

implementation="${1}"
if [ "$implementation" != "shibboleth" -a "$implementation" != "mellon" ] ; then
  echo "Only shibboleth and mellon are supported."
  exit 1
fi

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
source $HOME/devstack/accrc/admin/admin
export OS_IDENTITY_API_VERSION=3
ansible-playbook -vvvv -i "localhost," -c local \
                 --extra-vars "implementation=$implementation" \
                 playbooks/configure-federation.yml
