SHELL        := /usr/bin/env bash
.SHELLFLAGS  := -e -o pipefail -c
.NOTPARALLEL :

PROJECT_ROOT ?= $(shell git rev-parse --show-toplevel)
PROJECT_NAME ?= zsh-demo

DOCKER_CONTEXT ?= ${PROJECT_ROOT}
DOCKER_REPO    ?= ${PROJECT_NAME}
DOCKER_TAG     ?= latest

all: run

run: docker.build
	@docker run --rm -it \
		--name zsh-demo \
		--user "$$(id -u):$$(id -g)" \
		--hostname "${PROJECT_NAME}" \
		-v "${PROJECT_ROOT}/data/home:/home/zsh" \
		-v "${PROJECT_ROOT}/config/zshrc:/home/zsh/.zshrc" \
		-v "${PROJECT_ROOT}/config/starship.toml:/home/zsh/.config/starship.toml" \
		-v "$${DOCKER_SOCKET:-/var/run/docker.sock}:/var/run/docker.sock" \
		"${DOCKER_REPO}:${DOCKER_TAG}"

docker.build: .docker.build

.docker.build: Dockerfile
	@docker build \
		--build-arg UID="$$(id -u)" \
		--tag "${DOCKER_REPO}:${DOCKER_TAG}" \
		${DOCKER_CONTEXT}
	touch .docker.build

slides:
	@docker compose -f "${PROJECT_ROOT}/presentation/docker-compose.yml" up -d
	open http://127.0.0.1:8080

clean:
	rm .docker.build

distclean:
	git clean -xdf

.PHONY: run docker.build slides clean
