server-restart:
	docker compose -f docker-compose-dev.yml down -v --remove-orphans
	docker compose -f docker-compose-dev.yml up -d

down:
	docker compose -f docker-compose-dev.yml down --remove-orphans

down-local:
	docker compose -f docker-compose-dev.yml down --remove-orphans

composer-install:
	docker compose -f docker-compose-dev.yml run --rm gms-php-cli composer install

docker-up:
	docker compose -f docker-compose-dev.yml up -d

docker-build:
	docker compose -f docker-compose-dev.yml build --pull

start:
	docker compose -f docker-compose-dev.yml up -d

composer-update:
	docker compose -f docker-compose-dev.yml run --rm gms-php-cli composer update

cron:
	docker compose -f docker-compose-dev.yml run --rm gms-php-cli bin/console cron