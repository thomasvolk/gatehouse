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

### build the docker container

Run the build script to compile and pack the gatehouse archive file:

   ./build.sh

To create the docker container run the release script:

    ./release.sh

### run the container

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


Yous can test the release with the local test databse:

    docker-compose up

Run the gatehouse container as server:

    docker run \
    --network host \
    -e REPLACE_OS_VARS=true \
    -e PORT=9998 \
    -e GATEHOUSE_WEB_SECRET_KEY_BASE=Dn0MUHCWLaC1zC6JnAWqZrl5hs2M71f8F6PxXTPfJXAc8Lv82OYcV/uwuB42YA9K \
    -e GATEHOUSE_DB_HOST=localhost \
    -e GATEHOUSE_DB_NAME=gatehouse \
    -e GATEHOUSE_DB_USER=gatehouse \
    -e GATEHOUSE_DB_PASSWORD=gatehouse \
    -e GATEHOUSE_DB_PORT=13306 \
    -e GATEHOUSE_AUTH_SECRET_KEY=dev_A1yzSKfmfiQgwZ08vIeuXUQqkG8 \
    -e GATEHOUSE_AUTH_TOKEN_TTL=3600 \
    -p 9998:9998 \
    gatehouse-release

Open gatehose with http://localhost:9998

Run gatehouse container:

    docker run -it \
    --network host \
    -e REPLACE_OS_VARS=true \
    -e PORT=9998 \
    -e GATEHOUSE_WEB_SECRET_KEY_BASE=Dn0MUHCWLaC1zC6JnAWqZrl5hs2M71f8F6PxXTPfJXAc8Lv82OYcV/uwuB42YA9K \
    -e GATEHOUSE_DB_HOST=localhost \
    -e GATEHOUSE_DB_NAME=gatehouse \
    -e GATEHOUSE_DB_USER=gatehouse \
    -e GATEHOUSE_DB_PASSWORD=gatehouse \
    -e GATEHOUSE_DB_PORT=13306 \
    -e GATEHOUSE_AUTH_SECRET_KEY=dev_A1yzSKfmfiQgwZ08vIeuXUQqkG8 \
    -e GATEHOUSE_AUTH_TOKEN_TTL=3600 \
    -p 9998:9998 \
    gatehouse-release \
    /usr/local/lib/gatehouse/bin/gatehouse console

start a container from the lastest image:

    docker run \
    --network host \
    -e REPLACE_OS_VARS=true \
    -e PORT=9998 \
    -e GATEHOUSE_WEB_SECRET_KEY_BASE=Dn0MUHCWLaC1zC6JnAWqZrl5hs2M71f8F6PxXTPfJXAc8Lv82OYcV/uwuB42YA9K \
    -e GATEHOUSE_DB_HOST=localhost \
    -e GATEHOUSE_DB_NAME=gatehouse \
    -e GATEHOUSE_DB_USER=gatehouse \
    -e GATEHOUSE_DB_PASSWORD=gatehouse \
    -e GATEHOUSE_DB_PORT=13306 \
    -e GATEHOUSE_AUTH_SECRET_KEY=dev_A1yzSKfmfiQgwZ08vIeuXUQqkG8 \
    -e GATEHOUSE_AUTH_TOKEN_TTL=3600 \
    -p 9998:9998 \
     thomasvolk-docker-gatehouse.bintray.io/gatehouse/gatehouse



## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
