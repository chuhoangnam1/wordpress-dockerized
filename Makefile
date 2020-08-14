.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
build: ## Build docker images using docker-compose.yml
	docker-compose -f docker-compose.yml build $(c)
up: ## Start docker-compose stack
	docker-compose -f docker-compose.yml up -d $(c)
down: ## Stop docker-compose stack
	docker-compose -f docker-compose.yml down $(c)
start: ## Start a specific service from docker-compose
	docker-compose -f docker-compose.yml start $(c)
stop: ## Stop a specific service from docker-compose
	docker-compose -f docker-compose.yml stop $(c)
kill: ## Kill a specific service from docker-compose
	docker-compose -f docker-compose.yml kill $(c)
destroy: ## Take down a service from docker-compose
	docker-compose -f docker-compose.yml down -v $(c)
restart: ## Restart docker-compose stack
	docker-compose -f docker-compose.yml stop $(c)
	docker-compose -f docker-compose.yml up -d $(c)
logs: ## Show logs from docker-compose
	docker-compose -f docker-compose.yml logs --tail=100 -f $(c)
ps: ## List processes
	docker-compose -f docker-compose.yml ps
login-wordpress: ## Login to bash for wordpress service
	docker-compose -f docker-compose.yml exec wordpress /bin/bash
db-shell: ## mysql shell
	docker-compose -f docker-compose.yml exec db bash -l
mount: ## Mount wp-content directory for better compability
	mkdir -p $(shell pwd)/data/wordpress
	sudo bindfs -o force-user=http -o force-group=http -o create-for-user=http -o create-for-group=http -o perms=0755 $(shell pwd)/wordpress $(shell pwd)/data/wordpress
umount: ## Unmount wp-content directory
	sudo umount wordpress
