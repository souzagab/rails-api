development_path = .docker/dev/docker-compose.yml

## Misc
list: # List all available targets for this Makefile
	@grep '^[^#[:space:]].*:' Makefile

## Development
stop: # Stop all containers
	docker compose -f $(development_path) down

clean: # Stop and remove all containers, volumes and images
	docker compose -f $(development_path) down --rmi all --volumes --remove-orphans

build: stop # Build the containers
	docker compose -f $(development_path) build --no-cache
	docker compose -f $(development_path) run --rm api bin/setup

bash: # Open a bash session in the api container
	docker compose -f $(development_path) run --rm api bash

server: stop # Start the server
	docker compose -f $(development_path) up
