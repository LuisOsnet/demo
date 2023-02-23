.DEFAULT_GOAL := help
.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

setup: ## Install dependencies from Gemfile.
	bundle install

test: ## Run test suite (Rspec).
	bundle exec rspec spec/*

rubocop: ## Run linter (Rubocop).
	bundle exec rubocop

doc: ## Generate documentation (Rdoc).
	bundle exec rake rswag:specs:swaggerize

dkr-build: ## Build project on Docker.
	docker-compose build

dkr-setub: ## Build and rails prepare.
	docker-compose build && docker-compose run web rake db:drop db:create db:migrate db:seed

dkr-start: ## lunch the project on Docker.
	docker-compose up

dkr-debug-mode: ## lunch the project on Docker as developer mode.
	docker-compose run --service-ports web

dkr-console: ## lunch the console on Docker.
	docker-compose run web bash