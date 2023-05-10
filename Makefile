development_path = .docker/dev/docker-compose.yml

## Misc
list: # List all available targets for this Makefile
	@grep '^[^#[:space:]].*:' Makefile

## Development
stop:
	docker compose -f $(development_path) down

clean:
	docker compose -f $(development_path) down --rmi all --volumes --remove-orphans

build: stop
	docker compose -f $(development_path) build --no-cache
	docker compose -f $(development_path) run --rm api bin/setup

bash:
	docker compose -f $(development_path) run --rm api bash

server: stop
	docker compose -f $(development_path) up