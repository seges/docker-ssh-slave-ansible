# Jenkins SSH slave with Ansible

Jenkins SSH slave with Ansible inside so you don't need to install Ansible on global level.

[![Docker Container](http://dockeri.co/image/seges/ssh-slave-ansible)](https://registry.hub.docker.com/u/seges/ssh-slave-ansible/)

Versions:

* SSH slave latest
* Ansible 2.7.5

# Usage

In docker compose file:

```
version: '2'

services:
  ssh-slave-ansible:
    build: .
    image: seges/ssh-slave-ansible:1.0.0
    environment:
      - JENKINS_SLAVE_SSH_PUBKEY=abc...
```

Use the same principle as [Jenkins SSH Slave](https://hub.docker.com/r/jenkinsci/ssh-slave)
