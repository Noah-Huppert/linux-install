.PHONY: all build run rm

USER=noahhuppert
NAME=linux-install-mkiso
TAG=latest
FULL_TAG=${USER}/${NAME}:${TAG}

# Build and run docker image
all: build run

# Build docker image
build:
	docker build -t "${FULL_TAG}" .

# Run docker image
run:
	docker run -it --rm "${FULL_TAG}"

# Remove docker image
rm:
	docker image rm "${FULL_TAG}"
