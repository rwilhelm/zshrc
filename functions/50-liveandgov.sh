function lg-pg-ssh-tunnel() {
	nc -z localhost 3333 >|/dev/null || ssh -NfL 3333:lg:5432 rene@lg
}

function lg-psql() {
	psql -E -h localhost -p 3333 -U postgres liveandgov_dev
}

function lg-tail-postgres-log() {
	ssh -t rene@lg 'sudo tail -fn0 /var/log/postgresql/postgresql-9.3-main.log'
}

function lg-status-forever() {
	ssh rene@lg 'forever list'
}

function lg-status() {
ssh -t rene@lg "sudo tail -n30 /var/log/postgresql/postgresql-9.3-main.log"
	ssh rene@lg 'forever list'
}