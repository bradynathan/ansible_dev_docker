# Ansible Development Environment
This is creates a docker contain to write Ansible code.

## Source Image
Currently supporting base centos and rhel7.  Your internal source can be provided in the `FROM` keyword.

    FROM centos
## Environment Variables
The Environment variables can be configured in the `Dockerfile` to alter container configuration.

    ENV USERNAME developer
    ENV PASSWORD developer

## Use

### Building

    docker build --rm -t <username>/ssh:ansible .

### Running

    docker run -d -p 22 <username>/ssh:ansible

### Connecting

    $ docker ps
    CONTAINER ID        IMAGE                     COMMAND               CREATED             STATUS              PORTS                   NAMES
    5e3bc001572c        <username>/ssh:ansible   "/usr/sbin/sshd -d"   11 seconds ago      Up 10 seconds       0.0.0.0:32770->22/tcp   vigorous_hoover
    $ ssh developer@localhost -p 32770

Note:  You can not use localhost on Windows.  Use `docker-machine` to get the IP and tool like PuTTY to connect. 
