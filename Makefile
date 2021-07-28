PREFIX=paleozogt
ARCH=$(shell uname -m)

GIMME_AWS_CREDS_VER=2.4.3
AWSCLI_VER=1.20.9
DOCKER_ARGS=--build-arg GIMME_AWS_CREDS_VER=$(GIMME_AWS_CREDS_VER) --build-arg AWSCLI_VER=$(AWSCLI_VER)

all: gimme-aws-creds awscli

gimme-aws-creds:
	docker build --target $@ $(DOCKER_ARGS) -t $(PREFIX)/$@:$(GIMME_AWS_CREDS_VER)-$(ARCH) .
	docker tag $(PREFIX)/$@:$(GIMME_AWS_CREDS_VER)-$(ARCH) $(PREFIX)/$@:$(ARCH)
	docker push $(PREFIX)/$@:$(GIMME_AWS_CREDS_VER)-$(ARCH)
	docker push $(PREFIX)/$@:$(ARCH)

awscli:
	docker build --target $@ $(DOCKER_ARGS) -t $(PREFIX)/$@:$(AWSCLI_VER)-$(ARCH) .
	docker tag $(PREFIX)/$@:$(AWSCLI_VER)-$(ARCH) $(PREFIX)/$@:$(ARCH)
	docker push $(PREFIX)/$@:$(AWSCLI_VER)-$(ARCH)
	docker push $(PREFIX)/$@:$(ARCH)


