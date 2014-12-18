#!/bin/bash
#
set -x
sudo apt-get update
mkdir -p /etc/puppet/modules

puppet module install example42/puppi --version 2.1.9 --force
puppet module install example42/apache --version 2.1.7 --force
puppet module install puppetlabs/stdlib --version 4.2.2 --force
puppet module install puppetlabs/apt --version 1.4.2 --force
puppet module install maestrodev/wget --version 1.4.3 --force
