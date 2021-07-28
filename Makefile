PREFIX=paleozogt
ARCH=$(shell uname -m)

GIMME_AWS_CREDS_VER=2.4.3
AWSCLI_VER=1.20.9

all: gimme-aws-creds awscli

base: Dockerfile
	docker build --target builder -t $(PREFIX)/aws-tools-builder:$(ARCH) .

gimme-aws-creds: base
	docker build --target gimme-aws-creds --build-arg GIMME_AWS_CREDS_VER=$(GIMME_AWS_CREDS_VER) -t $(PREFIX)/gimme-aws-creds:$(GIMME_AWS_CREDS_VER)-$(ARCH) .
	docker tag $(PREFIX)/gimme-aws-creds:$(GIMME_AWS_CREDS_VER)-$(ARCH) $(PREFIX)/gimme-aws-creds:$(ARCH)
	docker push $(PREFIX)/gimme-aws-creds:$(GIMME_AWS_CREDS_VER)-$(ARCH)
	docker push $(PREFIX)/gimme-aws-creds:$(ARCH)

awscli: base
	docker build --target awscli --build-arg AWSCLI_VER=$(AWSCLI_VER) -t $(PREFIX)/awscli:$(AWSCLI_VER)-$(ARCH) .
	docker tag $(PREFIX)/awscli:$(AWSCLI_VER)-$(ARCH) $(PREFIX)/awscli:$(ARCH)
	docker push $(PREFIX)/awscli:$(AWSCLI_VER)-$(ARCH) 
	docker push $(PREFIX)/awscli:$(ARCH)
