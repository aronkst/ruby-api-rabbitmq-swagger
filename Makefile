start:
	docker compose up -d
	docker compose exec app ruby database.rb
	docker compose exec -d app ruby server.rb -o 0.0.0.0
	docker compose exec -d app ruby queue.rb

stop:
	docker compose stop
