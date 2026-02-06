# Makefile for Inception-like project

# Colors for prettier output
GREEN = \033[0;32m
RED   = \033[0;31m
NC    = \033[0m

# Docker Compose file location
DC = srcs/docker-compose.yml

# Default: show help
.DEFAULT_GOAL := help

## Help: Show this help
help:
	@echo "Usage: make <target>"
	@echo
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

## Build: Build all images
build: ## Build all Docker images
	@echo -e "$(GREEN)Building images...$(NC)"
	docker compose -f $(DC) build

## Up: Start all containers in foreground
up: ## Start all containers (foreground)
	@echo -e "$(GREEN)Starting containers...$(NC)"
	docker compose -f $(DC) up

## Upd: Start all containers in detached mode
upd: ## Start all containers (detached)
	@echo -e "$(GREEN)Starting containers (detached)...$(NC)"
	docker compose -f $(DC) up -d

## Down: Stop all containers
down: ## Stop all containers
	@echo -e "$(RED)Stopping containers...$(NC)"
	docker compose -f $(DC) down

## Logs: Show logs
logs: ## Show logs of all containers
	docker compose -f $(DC) logs -f

## Clean: Remove volumes and containers
clean: ## Remove containers, networks, and volumes
	@echo -e "$(RED)Cleaning containers and volumes...$(NC)"
	docker compose -f $(DC) down -v --remove-orphans

## Restart: Rebuild and restart containers
restart: clean build upd ## Rebuild images and restart containers
