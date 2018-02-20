CREATE TABLESPACE tbs_perm_02
DATAFILE 'tbs_perm_02.dat'
SIZE 100M
REUSE
AUTOEXTEND ON NEXT 20M MAXSIZE 2000M;

CREATE USER blockchain_schema IDENTIFIED BY blockchain DEFAULT TABLESPACE tbs_perm_02;

GRANT create session TO blockchain_schema;
GRANT create table TO blockchain_schema;
GRANT create view TO blockchain_schema;
GRANT create any trigger TO blockchain_schema;
GRANT create any procedure TO blockchain_schema;
GRANT create sequence TO blockchain_schema;
GRANT create synonym TO blockchain_schema;
GRANT UNLIMITED TABLESPACE TO blockchain_schema;

grant execute on sys.dbms_crypto to blockchain_schema;
