SHELL=/bin/sh
DOCKER=docker
DOCKER_COMPOSE=docker-compose
GIT=git
GIT_BASE=git@github.com:mobilityhouse

OWNER=mobilityhouse
PROJECT=protobuf3scala
VERSION=0.1.0 #$(shell cat VERSION)
REVISION=$(shell git rev-parse HEAD)

LIST_FILTER=-f "label=owner=${OWNER}" -f "label=project=${PROJECT}"
LIST_IMAGES=${DOCKER} images -a ${LIST_FILTER}
LIST_CONTAINERS=${DOCKER} ps -a ${LIST_FILTER}

image: Dockerfile
	${DOCKER} build \
		--rm --force-rm \
		-t "${OWNER}/${PROJECT}:develop" \
		--label "owner=${OWNER}" \
		--label "project=${PROJECT}" \
		.

clean-containers:
	$(eval CONTAINERS=$(shell ${LIST_CONTAINERS} -q))
	@if [ -n "${CONTAINERS}" ]; \
		then echo "removing containers ${CONTAINERS}" && \
		${DOCKER} rm ${CONTAINERS}; \
		else echo "No containers to remove"; \
		fi

clean-images-by-force:
	$(eval IMAGES=$(shell ${LIST_IMAGES} -q))
	@if [ -n "${IMAGES}" ]; \
		then echo "removing images ${IMAGES}" && \
		${DOCKER} rmi --force ${IMAGES}; \
		else echo "No images to remove"; \
		fi

clean-images:
	$(eval IMAGES=$(shell ${LIST_IMAGES} -q))
	@if [ -n "${IMAGES}" ]; \
		then echo "removing images ${IMAGES}" && \
		${DOCKER} rmi ${IMAGES}; \
		else echo "No images to remove"; \
		fi

list-containers: 
	${LIST_CONTAINERS}

list-images: 
	${LIST_IMAGES}

run:
	${DOCKER_COMPOSE} run workbench; \
		${DOCKER_COMPOSE} down

shell:
	${DOCKER_COMPOSE} run --entrypoint "/bin/bash" workbench; \
		${DOCKER_COMPOSE} down

shell-dev:
	${DOCKER_COMPOSE} up -d rmq; \
		${DOCKER_COMPOSE} run --entrypoint "/bin/bash" app; \
		${DOCKER_COMPOSE} down

logs:
	${DOCKER_COMPOSE} logs -f

pull:
	${DOCKER} pull ${OWNER}/${PROJECT}:develop

pull-dev:
	${DOCKER} pull ${OWNER}/${PROJECT}:develop

.PHONY: \
	clean-containers clean-images clean-images-by-force \
	image \
	list-containers list-images \
	run \
	shell shell-dev \
	logs \
	pull \
