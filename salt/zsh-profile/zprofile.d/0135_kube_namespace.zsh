# Source kube namespace file
. {{ pillar.kube_namespace.install_file }}
alias kubectl="kubens run"
