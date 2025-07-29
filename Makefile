DOCKER_COMPOSE = docker compose -f ./srcs/docker-compose.yml
WORDPRESS_DIR = /home/caburges/data/wordpress
MARIADB_DIR = /home/caburges/data/mariadb
NAME = inception

# Colors for output
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[0;33m
BLUE = \033[0;34m
NC = \033[0m # No Color

all: up

up: build
	@echo "$(YELLOW)🚀 Starting services...$(NC)"
	$(DOCKER_COMPOSE) up -d
	@echo "$(GREEN)🚀 Services built! You can connect at caburges.42.fr$(NC)"

down:
	@echo "$(RED)🛑 Stopping services...$(NC)"
	$(DOCKER_COMPOSE) down

build:
	@mkdir -p $(WORDPRESS_DIR)
	@mkdir -p $(MARIADB_DIR)
	@echo "$(YELLOW)🚀 Building services...$(NC)"
	$(DOCKER_COMPOSE) build


fclean:
	$(DOCKER_COMPOSE) down -v --remove-orphans
	#sudo rm -rf ~/data/*

logs:
	$(DOCKER_COMPOSE) logs -f

ps:
	$(DOCKER_COMPOSE) ps

re: fclean all

.PHONY: all up down build fclean re logs ps
