NAME=elasticsearch
all: build
build:
	docker build -t zoer/$(NAME) .
push:
	docker push zoer/$(NAME)
rm:
	docker rm -f $(NAME) 2>/dev/null || true
