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
# Enable Ansible venv at log in
