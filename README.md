# Gatehouse

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `(cd assets && npm install)`
  * Start the database with `docker-compose up`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

### add user

Start console without server:

    ./console

register user with generated password:

    iex(1)> Gatehouse.Manager.register("test@example.com")

### test

Strat the database:

    docker-compose up

Start the integrationtest application:

    ./integration-test/webserver.py

Open the url [`localhost:8000`](http://localhost:8000) from your browser.

## environment

To runthe service you must create a secret file: `config/prod.secret.exs`
Start the service in prod environment:

    export MIX_ENV=prod
    export PORT={{ your_port }}
    mix phx.server


ATTENTION: Use the 'dev' environment for testing only!

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
