# Sets Go environment variables

export GOPATH="{{ pillar.go.go_path }}"
mkdir -p "$GOPATH"

export PATH="$PATH:$GOPATH/bin"

export GO111MODULE=on
