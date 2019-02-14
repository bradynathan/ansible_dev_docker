#!/bin/bash

# Configure the virtualenv
pip install virtualenv

mkdir -p ${VENV_PATH}
cd ${VENV_PATH}

virtualenv ${VENV_NAME}

cd ${VENV_NAME}
source bin/activate

cat <<EOF > requests.txt
ansible==${ANSIBLE_VERSION}.*
asn1crypto
bcrypt
certifi
cffi
chardet
cryptography
enum34
hvac
idna
ipaddress
Jinja2
MarkupSafe
netaddr
ntlm-auth
oauthlib
paramiko
pyasn1
pycparser
pycrypto
pycurl
pykerberos
PyNaCl
pyOpenSSL
pyparsing
python-dateutil
pyvmomi
pywinrm
pyxattr
PyYAML
requests
requests-kerberos
requests-ntlm
requests-oauthlib
requestsexceptions
six
urllib3
xmltodict
EOF

pip install --upgrade pip
pip install -r requests.txt
