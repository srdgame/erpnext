#!/bin/bash
cd /home/frappe

apt-get install -y wget sudo python cron

wget https://raw.githubusercontent.com/srdgame/bench/master/playbooks/install.py -O /home/frappe/install.py
python /home/frappe/install.py --develop --user frappe

chown -R frappe:frappe frappe-bench/sites
su frappe -c "cd /home/frappe/frappe-bench && bench get-app erpnext https://github.com/frappe/erpnext"

# Create site and install ERPNext
#/etc/init.d/cron start
#/etc/init.d/mysql start
#su frappe -c "cd /home/frappe/frappe-bench && bench new-site site1.local --mariadb-root-password=frappe_pass --admin-password=admin"
#su frappe -c "cd /home/frappe/frappe-bench && bench --site site1.local install-app erpnext"
#/etc/init.d/mysql stop
#/etc/init.d/cron stop

# Remove dev pkgs
apt-get -y remove build-essential python-dev python-software-properties libmariadbclient-dev libxslt1-dev libcrypto++-dev libssl-dev

exit 0
