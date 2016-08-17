.PHONY: build build-dev build-prod up start stop logs introspect ps restart test build-hosts-file deploy ps run

ENV?=dev
SHELL=bash

ifeq (prod, $(ENV))
	SHELL=sh
endif

build:
ifeq (dev, $(ENV))
	@$(MAKE) build-dev
else ifeq (prod, $(ENV))
	@$(MAKE) build-prod
endif

build-dev:
	@docker build -f docker/Dockerfile-dev -t akerouanton-name:dev .

build-prod: build-dev
	@if [ ! -d _site ]; then mkdir _site; fi
	@docker run -v $(shell pwd)/_site:/usr/src/app/_site --rm --user $(shell id -u):$(shell id -g) akerouanton-name:dev jekyll build
	@docker build -f docker/Dockerfile -t akerouanton-name:prod .

up: start

run: start

start:
ifeq (dev, $(ENV))
	@docker run -v $(shell pwd):/usr/src/app -d -p 80:4000 --name akerouanton-name-dev akerouanton-name:dev
else
	@docker run -d -p 80:80 --name akerouanton-name-prod akerouanton-name:prod
endif

stop:
	@docker rm -f akerouanton-name-$(ENV)

logs:
	@docker logs -f akerouanton-name-$(ENV)

introspect:
	@docker exec -it akerouanton-name-$(ENV) $(SHELL)

ps:
	+@docker ps -a | grep akerouanton-name

restart: stop start

test:
	@wget -qO /dev/null http://localhost/

build-hosts-file:
	@echo "container_host ansible_host=$(DEPLOY_IP) ansible_user=$(DEPLOY_USER)" > ansible/hosts

deploy: build-hosts-file
	cd ansible && ansible-playbook -i hosts deploy.yml

rm:
	docker rm akerouanton-name-$(ENV)
