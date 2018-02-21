FROM araczkowski/oracle-apex-ords

MAINTAINER Yulia M.

ENV PASSWORD secret

# all installation files
COPY src/main/resources/sql /sql
COPY src/main/resources/scripts /scripts
COPY src/main/resources/apex /apex

ENTRYPOINT ["/scripts/entrypoint.sh"]

