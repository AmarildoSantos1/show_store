# README

Como rodar com o docker

```bash
docker-compose build
docker-compose up
```

executar o comando para rodar as migrações (apenas no primeiro uso)

```bash
docker-compose run web rake db:migrate RAILS_ENV=development
```

