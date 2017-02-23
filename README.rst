Federated Devstack
==================

Ansible playbooks to set up a minimal devstack with testshib.org as the
identity provider.

To use shibboleth as the SAML2 SP implementation, run

```
./gimme-cloud.sh shibboleth
```

To use mod_auth_mellon instead, run

```
./gimme-cloud.sh mellon
```

This script expects to be run on an Ubuntu Trusty or Xenial VM with certain
dependencies already installed. You can build such a VM with diskimage-builder
using the command:

```
disk-image-create -u pip-and-virtualenv devuser dhcp-all-interfaces vm cloud-init-nocloud -p python,git,libssl-dev --image-size 30 -o ubuntu.qcow2
```
