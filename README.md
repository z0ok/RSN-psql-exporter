# RSN-psql-exporter
RSN-psql-exporter

https://github.com/prometheus-community/postgres_exporter

https://github.com/prometheus-community/postgres_exporter/releases/download/v0.12.0/postgres_exporter-0.12.0.linux-amd64.tar.gz

https://habr.com/ru/articles/480902/

https://mcs.mail.ru/docs/additionals/cases/cases-monitoring/case-psql-exporter#

https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/

https://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip

```
CREATE ROLE psql_exporter WITH LOGIN PASSWORD 'secret';
ALTER ROLE psql_exporter CONNECTION LIMIT 3;
GRANT pg_monitor TO psql_exporter;   -- system role available for v10+ servers to reduce superuser usage
GRANT CONNECT ON DATABASE mydb TO psql_exporter;
```

# Backup
К одной таблице:

```
CREATE USER psql_backup WITH PASSWORD 'YOUTPASSWORDHERE' LOGIN;
GRANT CONNECT ON DATABASE "DATABASENAME" to psql_backup;
GRANT SELECT ON schema.table TO psql_backup;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO psql_backup;
```

На все таблицы:
```
CREATE USER psql_backup WITH PASSWORD 'YOUTPASSWORDHERE' LOGIN;
GRANT CONNECT ON DATABASE "DATABASENAME" to psql_backup;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO psql_backup;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO psql_backup;
```

Backup cron:
```
### Setting up
PG_HOST="127.0.0.1"
PG_USER="USER"
PG_DB="DB"
PG_TABLE="TABLE"
PG_SCHEMA="SCHEMA"
CURR_DATE=$(date +\%Y-\%m-\%d-\%H-\%M);
BCKP_DIR="/opt/backups";

### Creating PATH for backups with current time-date;
mkdir -p $BCKP_DIR/$CURR_DATE;
pg_dump "postgres://$PG_USER:@$PG_HOST:5432/$PG_DB" --table="$PG_SCHEMA"."$PG_TABLE" > $BCKP_DIR/$CURR_DATE/$PG_TABLE.dump
tar -czvf $BCKP_DIR/$CURR_DATE.tar.gz #BCKP_DIR/$CURR_DATE/$PG_TABLE.dump
#rm -r $BCKP_DIR/$CURR_DATE
```
