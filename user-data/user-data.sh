#!/bin/bash
# 1. Fix DNS
echo "nameserver 10.0.137.229" > /etc/resolv.conf
echo "nameserver 10.0.148.61" >> /etc/resolv.conf
 
# 2. Update and install packages
yum update -y
yum install -y sssd realmd adcli samba-common-tools oddjob oddjob-mkhomedir httpd amazon-efs-utils
 
# 3. Join Domain
echo "Starling123" | realm join Starling.Digital -U administrator --verbose
authselect select sssd with-mkhomedir --force
systemctl restart sssd
 
# 4. Mount EFS in background (&) so it doesn't block the boot process
mkdir -p /var/www/html
mount -t efs -o tls fs-03553634b1340969e:/ /var/www/html &
echo "fs-03553634b1340969e:/ /var/www/html efs _netdev,tls 0 0" >> /etc/fstab
 
# 5. Ensure Web Server starts regardless of mount status
systemctl start httpd
systemctl enable httpd
echo '{"status": "success", "message": "Starling Digital API Ready"}' > /var/www/html/index.html
 
# 6. RBAC Setup
groupadd sysadmin_local
groupadd developers_local
usermod -aG sysadmin_local admin@starling.digital
usermod -aG developers_local arif@starling.digital
touch /var/log/financial-audit.log
chown root:sysadmin_local /var/log/financial-audit.log
chmod 660 /var/log/financial-audit.log
