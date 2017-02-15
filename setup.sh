#!/bin/bash
cd /home/frappe

apt-get install -y wget sudo python cron

wget https://raw.githubusercontent.com/srdgame/bench/master/playbooks/install.py -O /home/frappe/install.py
python /home/frappe/install.py --develop --user frappe

# Remove dev pkgs
apt-get -y remove build-essential python-dev python-software-properties libmariadbclient-dev libxslt1-dev libcrypto++-dev libssl-dev

exit 0
