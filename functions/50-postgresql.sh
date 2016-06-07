function pg-types() {
	psql -c "select oid, typname from pg_type where typtype = 'b' order by oid"
}


#@SERVICE_MANAGEMENT
function restart-postgres () {
  launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
}
