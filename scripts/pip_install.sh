#!/bin/bash

PIP_DOWNLOAD=$(curl -Lsk ${PYPI_INDEX}/pip | grep tar.gz | tail -n1 | sed -n 's/.*href="\([^"]*\).*/\1/p')

if echo ${PIP_DOWNLOAD} | grep '^\.\.';
  then PIP_DOWNLOAD="${PYPI_INDEX}/pip/${PIP_DOWNLOAD}"
fi

PIP_ARCHIVE=$(echo ${PIP_DOWNLOAD} | grep -oP 'pip-([0-9]+\.)+tar.gz')
wget ${PIP_DOWNLOAD}  -O /root/${PIP_ARCHIVE}
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

if [ -n "$PYPI_EXTRA_INDEX" ];
  then echo "extra-index-url = ${PYPI_EXTRA_INDEX}" >>  /etc/pip.conf
fi

# Update pip if pypi index not sorted
pip install -U pip
