#!/bin/bash

# @see https://bugs.launchpad.net/snapd/+bug/1826662/comments/8
sudo systemctl restart snapd.seeded.service

snap install docker
snap install microk8s --classic
sudo microk8s.status --wait-ready
usermod -a -G microk8s vagrant
echo "alias kubectl='microk8s kubectl'" > /home/vagrant/.bash_aliases
chown vagrant:vagrant /home/vagrant/.bash_aliases
echo "alias kubectl='microk8s kubectl'" > /root/.bash_aliases
chown root:root /root/.bash_aliases