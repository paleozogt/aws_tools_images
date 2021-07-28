PREFIX=paleozogt
ARCH=$(shell uname -m)

images: Dockerfile
	docker build --target builder -t $(PREFIX)/aws-tools-builder:$(ARCH) .
	docker build --target gimme-aws-creds -t $(PREFIX)/gimme-aws-creds:$(ARCH) .
	docker build --target awscli -t $(PREFIX)/awscli:$(ARCH) .

