GREEN		:= $(shell tput -Txterm setaf 2)
YELLOW		:= $(shell tput -Txterm setaf 3)
RED			:= $(shell tput -Txterm setaf 1)
RESET		:= $(shell tput -Txterm sgr0)
LOGIN=amyroshn

all: up

init: folders
	@$(shell git config --global user.email "$(LOGIN)@42.fr")
	@$(shell git config --global user.name "$(LOGIN)")
	@if [ ! -d "/usr/local/bin/docker-compose" ] || \
	@if [ ! -d "/usr/bin/docker" ]; then \
		echo "$(YELLOW)"; \
		sh install_dependencies.sh; \
		echo "$(RESET)"; \
	else\
		echo "$(GREEN)all dependencies ok $(RESET)"; \
	fi

	@sudo -- sh -c "echo 127.0.0.1 $(LOGIN).42.fr >> /etc/hosts"

	@echo "To start server    $(GREEN)make up$(RESET)"
	@echo "To stop server     $(RED)make down$(RESET)"
	@echo "To rebuild project $(YELLOW)make re$(RESET)"

folders:
	@if [ -d "/home/$(LOGIN)/data/www" ]; then\
		echo "$(GREEN)wordpress folder ok $(RESET)";\
	else\
		sudo mkdir -p /home/$(LOGIN)/data/www; \
		echo "$(YELLOW)wordpress folder has been created $(RESET)"; \
	fi

	@if [ -d "/home/$(LOGIN)/data/database" ]; then\
		echo "$(GREEN)mysql folder ok $(RESET)";\
	else\
		sudo mkdir -p /home/$(LOGIN)/data/database;\
		echo "$(YELLOW)mysql folder has been created $(RESET)";\
	fi

up: folders
	@echo "$(GREEN)Building containers in background$(RESET)"
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	@echo "$(YELLOW)Stopping all containers$(RESET)"
	@docker-compose -f srcs/docker-compose.yml down

list:
	@echo "$(YELLOW)Listing all containers$(RESET)"
	 docker ps -a

list_volumes:
	@echo "$(YELLOW)Listing volumes$(RESET)"
	docker volume ls

fclean:	down
	@echo "$(YELLOW)Cleaning images, volumes and cache$(RESET)"
	docker rmi -f $$(docker images -qa)
	docker volume rm $$(docker volume ls -q)
	docker system prune -a --force
	sudo rm -rf /home/${USER}/data/database
	sudo rm -rf /home/${USER}/data/www

re:
	docker-compose -f srcs/docker-compose.yml build
	docker-compose -f ./srcs/docker-compose.yml up -d --build

.PHONY: all init up down list list_volumes fclean re folders
