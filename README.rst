Federated Devstack
==================

Ansible playbooks to set up a minimal devstack with testshib.org as the
SAML2 identity provider or Google as the OpenID Connect identity provider.

To use shibboleth as the SAML2 SP implementation, run::

  ./gimme-cloud.sh shibboleth

To use mod_auth_mellon as the SAML2 SP implementation, run::

  ./gimme-cloud.sh mellon

To use OpenID Connect, get your Client ID and Client Secret from the Google
API Console, and set them as environment variables::

  export GOOGLE_OPENIDC_CLIENT_ID=<Google Client ID>
  export GOOGLE_OPENIDC_CLIENT_SECRET=<Google Client Secret>
  ./gimme-cloud.sh oidc

You must also add these redirect URIs to the project in the Google API console::

  http://mysp.example.com/identity/v3/OS-FEDERATION/identity_providers/myidp/protocols/mapped/auth
  http://mysp.example.com/identity/v3/auth/OS-FEDERATION/websso
  http://mysp.example.com/identity/v3/auth/OS-FEDERATION/identity_providers/myidp/protocols/mapped/websso

This script expects to be run on an Ubuntu Trusty or Xenial VM with certain
dependencies already installed. You can build such a VM with diskimage-builder
using the command::

  disk-image-create -u pip-and-virtualenv devuser dhcp-all-interfaces vm cloud-init-nocloud -p python,git,libssl-dev --image-size 30 -o ubuntu.qcow2

You must also ensure the instance where your devstack is running is accessible
from your browser by the domain name "mysp.example.com".
