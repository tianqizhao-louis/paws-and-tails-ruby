```bash
docker compose build
docker compose run --rm web db:create
docker compose run --rm web db:migrate
docker compose run --rm web db:seed
docker compose up
```