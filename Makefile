DOCKER_COMPOSE = docker compose -f ./srcs/docker-compose.yml
WORDPRESS_DIR = /home/caburges/data/wordpress
MARIADB_DIR = /home/caburges/data/mariadb
REDIS_DIR = /home/caburges/data/redis
NAME = inception

# Colors for output
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[0;33m
BLUE = \033[0;34m
NC = \033[0m # No Color

all: up

$(NAME): up

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
	@mkdir -p $(REDIS_DIR)
	@echo "$(YELLOW)🚀 Building services...$(NC)"
	$(DOCKER_COMPOSE) build

clean: down
	@echo "$(YELLOW)🧹 Cleaning containers...$(NC)"
	$(DOCKER_COMPOSE) rm -f
	@echo "$(GREEN)✅ Containers cleaned$(NC)"

fclean: clean
	@echo "$(RED)🔥 Full cleanup started...$(NC)"
	@echo "$(YELLOW)🗑️  Removing images...$(NC)"
	-docker rmi $$(docker images -q --filter "reference=srcs*") 2>/dev/null || true
	@echo "$(YELLOW)🗑️  Removing volumes...$(NC)"
	-docker volume rm $$(docker volume ls -q --filter "name=$(NAME)") 2>/dev/null || true
	@echo "$(YELLOW)🗑️  Removing data directories...$(NC)"
	@echo "$(YELLOW)🗑️  Pruning system...$(NC)"
	docker system prune -f
	@echo "$(GREEN)✅ Full cleanup completed$(NC)"

logs:
	@echo "$(BLUE)📋 Showing logs (Ctrl+C to exit)...$(NC)"
	$(DOCKER_COMPOSE) logs -f

ps:
	@echo "$(BLUE)📊 Container status:$(NC)"
	$(DOCKER_COMPOSE) ps

die:
	sudo rm -rf $(WORDPRESS_DIR)
	

re: fclean all

help:
	@echo "$(BLUE)Available targets:$(NC)"
	@echo "  $(GREEN)all$(NC)     - Build and start all services"
	@echo "  $(GREEN)$(NAME)$(NC) - Same as 'all'"
	@echo "  $(GREEN)up$(NC)      - Start services (builds if needed)"
	@echo "  $(GREEN)down$(NC)    - Stop services"
	@echo "  $(GREEN)build$(NC)   - Build all images"
	@echo "  $(GREEN)clean$(NC)   - Stop and remove containers"
	@echo "  $(GREEN)fclean$(NC)  - Full cleanup (containers, images, volumes, data)"
	@echo "  $(GREEN)re$(NC)      - Full restart (fclean + all)"
	@echo "  $(GREEN)logs$(NC)    - Show service logs"
	@echo "  $(GREEN)ps$(NC)      - Show container status"
	@echo "  $(GREEN)help$(NC)    - Show this help message"

.PHONY: all up down build fclean re logs ps help
