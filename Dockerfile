FROM elixir:1.14

RUN apt-get update && \
    apt-get install -y postgresql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /app

COPY . .

RUN mix local.hex --force
RUN mix local.rebar --force
RUN  mix deps.get

RUN mix compile

EXPOSE 4000

CMD ["mix", "phx.server"]
