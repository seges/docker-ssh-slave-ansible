FROM jenkinsci/ssh-slave:latest

# inspiration from https://github.com/William-Yeh/docker-ansible/blob/master/1.9-debian8/Dockerfile
# PIP version from https://pypi.org/project/ansible/

RUN echo "===> Installing python, sudo, and supporting tools..."  && \
    apt-get update -y  &&  apt-get install --fix-missing          && \
    DEBIAN_FRONTEND=noninteractive         \
    apt-get install -y                     \
        python python-yaml sudo            \
        curl gcc python-pip python-dev libffi-dev libssl-dev  && \
    apt-get -y --purge remove python-cffi    && \
    pip install --upgrade setuptools         && \
    pip install --upgrade pycrypto cffi      && \
    \
    \
    echo "===> Installing Ansible..."   && \
    pip install cryptography ansible==2.7.5          && \
    \
    \
    echo "===> Installing handy tools (not absolutely required)..."  && \
    apt-get install -y sshpass openssh-client  && \
    \
    \
    echo "===> Removing unused APT resources..."                  && \
    apt-get -f -y --auto-remove remove \
                 gcc python-dev libffi-dev libssl-dev  && \
#                 gcc python-pip python-dev libffi-dev libssl-dev  && \
    apt-get clean                                                 && \
    rm -rf /var/lib/apt/lists/*  /tmp/*                           && \
    \
    \
    echo "===> Adding hosts for convenience..."        && \
    mkdir -p /etc/ansible                              && \
    echo 'localhost' > /etc/ansible/hosts

ADD ssh/config /home/jenkins/.ssh/config
RUN chmod 0600 /home/jenkins/.ssh && \
    chmod 0600 /home/jenkins/.ssh/config && \
    chown -R 1000:1000 /home/jenkins/.ssh

