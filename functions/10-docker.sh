# http://docs.docker.io/en/latest/installation/mac/
#
# Forwarding VM Port Range to Host
#
# If we take the port range that docker uses by default with the -P option
# (49000-49900), and forward same range from host to vm, we’ll be able to
# interact with our containers as if they were running locally:
#
# vm must be powered off (`boot2docker down`)
#

export DOCKER_HOST=tcp://localhost:4243

function docker-port-forwarding () {
  for i in {49000..49900}; do
    VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port$i,tcp,,$i,,$i";
    VBoxManage modifyvm "boot2docker-vm" --natpf1 "udp-port$i,udp,,$i,,$i";
  done
}
