NAME=openvino
TAG=2021.4.2

build:
	docker build -t ${NAME}:${TAG} .

.PHONY: build
