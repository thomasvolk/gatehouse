# Gatehouse

To start your Phoenix server:

Install dependencies with

    mix deps.get

Create and migrate your database with

    mix ecto.create && mix ecto.migrate

Install Node.js dependencies with

    (cd assets && npm install)

Start the database with

    docker-compose up

Start Phoenix endpoint with

    mix phx.server

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

### add user

Start console without server:

    ./console

register user with generated password:

    iex(1)> Gatehouse.Manager.register("test@example.com")

### test

Start the integrationtest application:

    ./integration-test/webserver.py

Open the url [`localhost:8000`](http://localhost:8000) from your browser.

ATTENTION: Use the 'dev' environment for testing only!

## release

To run the release you must set the following environment variables:

| Name                             | Description                        |
|:-------------------------------- |:-----------------------------------|
| GATEHOUSE_DB_HOST                |  database host name                |
| GATEHOUSE_DB_NAME                |  database name                     |
| GATEHOUSE_DB_USER                |  database user name                |
| GATEHOUSE_DB_PASSWORD            |  database user passoerd            |
| GATEHOUSE_DB_PORT                |  database port                     |
| GATEHOUSE_DB_POOL_SIZE           |  default: 10                       |
| GATEHOUSE_WEB_SECRET_KEY_BASE    |  webserver secret key base         |
| GATEHOUSE_AUTH_ISSUER            |  authentication issuer             |
| GATEHOUSE_AUTH_SECRET_KEY        |  authentication secret key         |
| GATEHOUSE_AUTH_TOKEN_TTL         |  authentication token time to live |

test the release:

    docker run \
    -e PORT=9998 \
    -e GATEHOUSE_WEB_SECRET_KEY_BASE=Dn0MUHCWLaC1zC6JnAWqZrl5hs2M71f8F6PxXTPfJXAc8Lv82OYcV \
    -e GATEHOUSE_DB_HOST=172.17.0.1 \
    -e GATEHOUSE_DB_NAME=gatehouse \
    -e GATEHOUSE_DB_USER=gatehouse \
    -e GATEHOUSE_DB_PASSWORD=gatehouse \
    -e GATEHOUSE_DB_POOL_SIZE=10 \
    -e GATEHOUSE_DB_PORT=13306 \
    -e GATEHOUSE_AUTH_ISSUER=Gatehouse \
    -e GATEHOUSE_AUTH_SECRET_KEY=dev_A1yzSKfmfiQgwZ08vIeuXUQqkG8 \
    gatehouse-release

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
