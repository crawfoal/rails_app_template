pg_status = `pg_ctl status -D /usr/local/var/postgres`
unless pg_status.include? "server is running"
  say "Starting postgres server for you..."
  run "pg_ctl start -D /usr/local/var/postgres"
  run "pg_ctl status -D /usr/local/var/postgres"
end
