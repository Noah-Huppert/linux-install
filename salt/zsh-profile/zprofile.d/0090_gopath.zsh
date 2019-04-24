# Sets GOPATH

export GOPATH="{{ pillar.go.go_path }}"
mkdir -p "$GOPATH"

export PATH="$PATH:$GOPATH/bin"
