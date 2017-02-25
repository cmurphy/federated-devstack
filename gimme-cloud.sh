#!/usr/bin/env bash

set -eux

implementation="${1}"
if [ "$implementation" != "shibboleth" -a "$implementation" != "mellon" -a "$implementation" != "oidc" ] ; then
  echo "Only shibboleth, mellon, and oidc are supported."
  exit 1
fi
if [ "$implementation" == "oidc" ] ; then
  : ${GOOGLE_OPENIDC_CLIENT_ID?"You must set GOOGLE_OPENIDC_CLIENT_ID when using the oidc implementation"}
  : ${GOOGLE_OPENIDC_CLIENT_SECRET?"You must set GOOGLE_OPENIDC_CLIENT_SECRET when using the oidc implementation"}
fi

# TODO: remove when 2.3 is released
if [ -d $HOME/ansible ] ; then
  pushd $HOME/ansible
  git pull
  popd
else
  git clone https://github.com/ansible/ansible $HOME/ansible
fi
sudo pip install $HOME/ansible

ansible-playbook -vvvv -i "localhost," -c local playbooks/install-devstack.yml
source $HOME/devstack/accrc/admin/admin
export OS_IDENTITY_API_VERSION=3
ansible-playbook -vvvv -i "localhost," -c local \
                 --extra-vars "implementation=$implementation" \
                 playbooks/configure-federation.yml
