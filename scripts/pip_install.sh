#!/bin/bash

PIP_DOWNLOAD=$(curl -Lsk ${PYPI_INDEX}/pip | grep tar.gz | tail -n1 | sed -n 's/.*href="\([^"]*\).*/\1/p')
PIP_ARCHIVE=$(echo ${PIP_DOWNLOAD} | grep -oP 'pip-([0-9]+\.)+tar.gz')
curl -Lsk ${PIP_DOWNLOAD}  -o /root/${PIP_ARCHIVE}
cd /root
tar xf ${PIP_ARCHIVE}
cd $(basename ${PIP_ARCHIVE} .tar.gz)
python setup.py build
python setup.py install

# Update vim settings
cat <<EOF > /etc/pip.conf
[global]
timeout = 60
index-url = ${PYPI_INDEX}
EOF
