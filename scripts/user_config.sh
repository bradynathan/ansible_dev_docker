#!/bin/bash

# Create the user
useradd -c "Interactive SSH Account" ${USERNAME}
echo -e "${PASSWORD}\n${PASSWORD}" | (passwd --stdin ${USERNAME})
usermod -aG wheel ${USERNAME}

# Update vim settings
cat <<EOF > /home/${USERNAME}/.vimrc
autocmd FileType yaml setlocal et ts=2 ai sw=2 nu sts=0
set cursorline
set textwidth=80
EOF

chown ${USERNAME}:${USERNAME} -R /home/${USERNAME}

# Set up bash environment
echo "export PYCURL_SSL_LIBRARY=${PYCURL_SSL_LIBRARY}" >> /home/${USERNAME}/.bashrc
echo "source ${VENV_PATH}/${VENV_NAME}/bin/activate"  >> /home/${USERNAME}/.bashrc
# Enable Ansible venv at log in
