FROM debian:latest
MAINTAINER Dirk Chang <srdgame@gmail.com>
LABEL Description="ERPNext easy deployment" Vendor="srdgame" Version="1.0"

# Debian Mirrors
RUN sed -i 's/deb\.debian\.org/mirrors\.aliyun\.com/g' /etc/apt/sources.list
RUN apt-get update 

# Frappe
ENV FRAPPE_USER frappe
RUN useradd $FRAPPE_USER && mkdir /home/$FRAPPE_USER && chown -R $FRAPPE_USER.$FRAPPE_USER /home/$FRAPPE_USER
RUN usermod -G sudo $FRAPPE_USER
WORKDIR /home/$FRAPPE_USER
COPY setup.sh /
RUN bash /setup.sh

# System
RUN apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/ /home/$FRAPPE_USER/.cache

# Persistence
VOLUME ["/var/lib/mysql", "/home/frappe/frappe-bench/sites/site1.local/"]

# Ports
EXPOSE 8000

# Run
COPY run-erpnext.sh /
CMD /run-erpnext.sh
