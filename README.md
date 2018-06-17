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
| GATEHOUSE_DB_USER_NAME           |  database user name                |
| GATEHOUSE_DB_PASSWORD            |  database user passoerd            |
| GATEHOUSE_DB_PORT                |  database port                     |
| GATEHOUSE_DB_POOL_SIZE           |  default: 10                       |
| GATEHOUSE_WEB_SECRET_KEY_BASE    |  webserver secret key base         |
| GATEHOUSE_AUTH_ISSUER            |  authentication issuer             |
| GATEHOUSE_AUTH_SECRET_KEY        |  authentication secret key         |
| GATEHOUSE_AUTH_TOKEN_TTL         |  authentication token time to live |


## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
