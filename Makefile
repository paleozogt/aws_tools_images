PREFIX=paleozogt

images: Dockerfile
	docker build --target builder -t $(PREFIX)/aws-tools-builder .
	docker build --target gimme-aws-creds -t $(PREFIX)/gimme-aws-creds .
	docker build --target awscli -t $(PREFIX)/awscli .

