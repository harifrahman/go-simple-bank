.EXPORT_ALL_VARIABLES:

USERNAME=root
PASSWORD=secret

.PHONY: postgres createdb dropdb migrateup migratedown build sqlc

postgres:
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=$(USERNAME) -e POSTGRES_PASSWORD=$(PASSWORD) -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=$(USERNAME) --owner=$(USERNAME) simple_bank

dropdb:
	docker exec -it postgres12 dropdb simple_bank

migrateup:
	migrate -path db/migrations -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migrations -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

initschema:
	migrate create -ext sql -dir db/migrations -seq init_schema

sqlc:
	sqlc generate

# =============================================================
# for first time, we can run this
# write sql command for migrate up & down, and then run `migrateup`
# =============================================================
build:
	postgres
	createdb
	initschema
