# Gatehouse

To start your Phoenix server:

Install dependencies with

    mix deps.get

Create and migrate your database with

    mix ecto.create && mix ecto.migrate

Install Node.js dependencies with

    (cd assets && npm install)

Start the database with

    docker-compose -f docker-compose-development.yaml up

Start Phoenix endpoint with

    mix phx.server

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser and register the admin user.

You can test the sso function by open the demo server on [`localhost:8001`](http://localhost:8001).

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

### test

Start the integrationtest application:

    ./example/python/webserver.py

Open the url [`localhost:8000`](http://localhost:8000) from your browser.

ATTENTION: Use the 'dev' environment for testing only!

### create migration script

If you change the database model, you have to create a migration script:

    mix ecto.gen.migration {{ my_change_description }}
    mix ecto.migrate

## release

### build and run the docker container

Run the build script to compile and pack the gatehouse archive file:

   ./build.sh

To create the docker container run the release script:

    ./build-docker-release.sh

Yous can test the release with the local test database:

    docker-compose up

Open gatehose with http://localhost:9998

### docker container environment variables

To run the release you must set the following environment variables:

| Name                             | Description                        |
|:-------------------------------- |:-----------------------------------|
| GATEHOUSE_DATABASE_URL           |  database host name                |
| GATEHOUSE_DB_NAME                |  database name                     |
| GATEHOUSE_DB_USER                |  database user name                |
| GATEHOUSE_DB_PASSWORD            |  database user passoerd            |
| GATEHOUSE_DB_PORT                |  database port                     |
| GATEHOUSE_WEB_SECRET_KEY_BASE    |  webserver secret key base         |
| GATEHOUSE_AUTH_SECRET_KEY        |  authentication secret key         |
| GATEHOUSE_AUTH_TOKEN_TTL         |  authentication token time to live |

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
