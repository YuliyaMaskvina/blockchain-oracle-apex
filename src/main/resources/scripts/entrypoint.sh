#!/bin/bash

exec >> >(tee -ai /docker_log.txt)
exec 2>&1

# # Update hostname
sed -i -E "s/HOST = [^)]+/HOST = $HOSTNAME/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora
sed -i -E "s/HOST = [^)]+/HOST = $HOSTNAME/g" /u01/app/oracle/product/11.2.0/xe/network/admin/tnsnames.ora
sed -i -E "s/PORT = [^)]+/PORT = 1521/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora
#
/etc/init.d/oracle-xe start
/etc/init.d/tomcat start
/etc/init.d/ssh start

/scripts/run_sql.sh

##
## Workaround for graceful shutdown. ....ing oracle... ‿( ́ ̵ _-`)‿
##
while [ "$END" == '' ]; do
	sleep 1
	trap "/etc/init.d/oracle-xe stop && END=1" INT TERM
done
;;