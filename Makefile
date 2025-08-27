NAME = inception
SERVICES = adminer \
			ftp \
			nginx \
			wordpress \
			mariadb \
			staticsite \
			portainer \
			redis 

DOCKER_COMPOSE = docker compose -f ./srcs/docker-compose.yml
WORDPRESS_DIR = /home/caburges/data/wordpress
MARIADB_DIR = /home/caburges/data/mariadb
REDIS_DIR = /home/caburges/data/redis
PORTAINER_DIR = /home/caburges/data/portainer
SECRETS_SRC = /home/caburges/Documents/Inception/secrets
ENVFILE_SRC = /home/caburges/Documents/Inception/.env
ENV =./srcs/.env
SECRETS = ./secrets
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
	@echo "$(YELLOW)Starting services...$(NC)"
	$(DOCKER_COMPOSE) up -d
	@echo ""
	@echo "$(GREEN)Services started! You can connect to your services here:$(NC)"
	@echo "  WordPress:       https://caburges.42.fr"
	@echo "  WP dashboard:    https://caburges.42.fr/wp-admin"
	@echo "  Adminer:         http://localhost:8080					(wp database UI)"
	@echo "  FTP:             lftp ftpuser@localhost				(file transfer, in terminal)"
	@echo "  Portainer:       http://localhost:9000					(container management)"
	@echo "  Redis:           (internal service, use wp-admin)		(wp cache)"
	@echo "  MariaDB:         (internal service, use Adminer)		(wp database)"
	@echo "  Static site:     https://staticsite.fr"
	@echo ""
	@echo "$(GREEN)Run 'make help' to see available commands$(NC)"

down:
	@echo "$(RED)Stopping services & removing containers...$(NC)"
	-$(DOCKER_COMPOSE) down

build:
	@if [ ! -f ./srcs/.env ]; then \
		echo "$(YELLOW)Copying .env into repo...$(NC)"; \
		cp $(ENVFILE_SRC) $(ENV); \
	fi

	@if [ ! -d ./secrets ]; then \
		echo "$(YELLOW)Copying secrets folder into repo...$(NC)"; \
		cp -r $(SECRETS_SRC) $(SECRETS); \
	fi

	@mkdir -p $(WORDPRESS_DIR)
	@mkdir -p $(MARIADB_DIR)
	@mkdir -p $(REDIS_DIR)
	@mkdir -p $(PORTAINER_DIR)
	@echo "$(YELLOW)Building services...$(NC)"
	-$(DOCKER_COMPOSE) build $(BUILD_ARGS)

clean: down
	@echo "$(GREEN)✅ Containers cleaned$(NC)"

fclean: clean
	@echo "$(RED)Full cleanup started...$(NC)"
	@echo "$(YELLOW)Removing images...$(NC)"
	-$(foreach service,$(SERVICES),docker rmi $$(docker images -q --filter=reference="$(service)*") 2>/dev/null || true;)
	@echo "$(YELLOW)Removing volumes...$(NC)"
	-$(foreach service,$(SERVICES),docker volume rm inception_$(service) 2>/dev/null || true;)
	@echo "$(YELLOW)Pruning system...$(NC)"
	docker system prune -a -f
	@echo "$(YELLOW)Removing .env ...$(NC)"
	rm -f $(ENV)
	@echo "$(YELLOW)Removing .env ...$(NC)"
	rm -rf $(SECRETS)
	@echo "$(GREEN)✅ Full cleanup completed$(NC)"

stop:
	@echo "$(RED)Stopping services...$(NC)"
	-$(DOCKER_COMPOSE) stop
logs:
	@echo "$(BLUE)Showing logs (Ctrl+C to exit)...$(NC)"
	$(DOCKER_COMPOSE) logs -f

ps:
	@echo "$(BLUE)Container status:$(NC)"
	$(DOCKER_COMPOSE) ps

die: fclean
	sudo rm -rf $(WORDPRESS_DIR)
	sudo rm -rf $(MARIADB_DIR)
	sudo rm -rf $(REDIS_DIR)
	
re: fclean all

help:
	@echo "$(BLUE)Available targets:$(NC)"
	@echo "  $(GREEN)all$(NC)     - Build and start all services"
	@echo "  $(GREEN)$(NAME)$(NC) - Same as 'all'"
	@echo "  $(GREEN)build$(NC)   - Build all images"
	@echo "  $(GREEN)up$(NC)      - Start services (builds if needed)"
	@echo "  $(GREEN)down$(NC)    - Stop services & remove containers"
	@echo "  $(GREEN)clean$(NC)   - Stop and remove containers"
	@echo "  $(GREEN)fclean$(NC)  - Full cleanup (containers, images, volumes)"
	@echo "  $(GREEN)re$(NC)      - Full restart (fclean + all)"
	@echo "  $(GREEN)logs$(NC)    - Show service logs"
	@echo "  $(GREEN)ps$(NC)      - Show container status"
	@echo "  $(GREEN)help$(NC)    - Show this help message"
	@echo ""
	@echo "$(GREEN)You can connect to your services here:$(NC)"
	@echo "  WordPress:       https://caburges.42.fr"
	@echo "  WP dashboard:    https://caburges.42.fr/wp-admin"
	@echo "  Adminer:         http://localhost:8080					(wp database UI)"
	@echo "  FTP:             lftp ftpuser@localhost				(file transfer, in terminal)"
	@echo "  Portainer:       http://localhost:9000					(container management)"
	@echo "  Redis:           (internal service, use wp-admin)		(wp cache)"
	@echo "  MariaDB:         (internal service, use Adminer)		(wp database)"
	@echo "  Static site:     https://staticsite.fr"
	@echo ""

.PHONY: all up down build fclean re logs ps help die stop
