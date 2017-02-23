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
