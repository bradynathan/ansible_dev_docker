FROM centos
MAINTAINER https://github.com/bradynathan

# User configurable environment variables
ENV USERNAME developer
ENV PASSWORD developer
ENV PYPI_INDEX https://pypi.org/simple
# ENV PYPI_EXTRA_INDEX https://pypi.org/simple
ENV ANSIBLE_VERSION 2.7
ENV VENV_PATH /opt/venv
ENV VENV_NAME ansible


ENV HOME /root
ENV PYCURL_SSL_LIBRARY openssl

WORKDIR /root

RUN yum install -y git gcc python python-devel krb5-devel openssl-devel libcurl-devel sshpass vim openssh-server passwd wget curl bind-utils iputils bash-completion man sudo python-setuptools; yum clean all

ADD scripts /root/scripts
RUN /bin/bash /root/scripts/pip_install.sh
RUN /bin/bash /root/scripts/ansible_venv.sh
RUN /bin/bash /root/scripts/sshd_config.sh
RUN /bin/bash /root/scripts/user_config.sh
#
# EXPOSE 22
#
ENTRYPOINT ["/usr/bin/supervisord"]
