#!/bin/bash
#PASSWORD=${1:-secret}

SQLPLUS=sqlplus
SQLPLUS_ARGS="sys/$PASSWORD@XE as sysdba"

verify_connection(){
	echo "exit" | ${SQLPLUS} -L $SQLPLUS_ARGS | grep Connected > /dev/null
	if [ $? -eq 0 ];
	then
	   echo "Database Connetion is OK"
	else
	   echo -e "Database Connection Failed. Connection failed with:\n $SQLPLUS -S $SQLPLUS_ARGS\n `$SQLPLUS -S $SQLPLUS_ARGS` < /dev/null"
	   exit 1
	fi

	if [ "$(ls -A /u01/app/oracle)" ]; then
		echo "Check Database files folder: OK"
	else
		echo -e "Failed to find database files, run example:\n docker run -it --rm --volumes-from $oracle_db_name:oracle-database --link $oracle_db_name:oracle-database apex_ords install"
		exit 1
	fi
}

install_crypto(){
	cd /u01/app/oracle/product/11.2.0/xe/rdbms/admin/
	echo "Installing DBMS_CRYPTO..."
	$SQLPLUS -S $SQLPLUS_ARGS @dbmsobtk.sql
}


create_tables(){
	cd /sql
	echo "Creating new blockchain tables"
	$SQLPLUS -S $SQLPLUS_ARGS @00_new_user.sql
	$SQLPLUS -S $SQLPLUS_ARGS @01_blockchain_table.sql
	$SQLPLUS -S $SQLPLUS_ARGS @02_blockchain_sequence.sql
	$SQLPLUS -S $SQLPLUS_ARGS @03_blockchain_trigger.sql
    $SQLPLUS -S $SQLPLUS_ARGS @blockchain_pkg.pks
	$SQLPLUS -S $SQLPLUS_ARGS @blockchain_pkg.pkb
}

import_app(){
	cd /apex
	echo "Importing blockchain application"
	$SQLPLUS -S $SQLPLUS_ARGS @import_all.sql
}


verify_connection
install_crypto
create_tables
import_app
