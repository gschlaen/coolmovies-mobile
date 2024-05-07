# coolmovies_mobile

Coolmovies challenge

- [Introduction: Coolmovies challenge](#introduction-coolmovies-challenge)
- [Web version challenge](#web-version-challenge)
- [Mobile version challenge](#mobile-version-challenge)
  - [Requirements](#requirements)
  - [Running the server](#running-the-server)
  - [Play around with some examples](#play-around-with-some-examples)
  - [Reinitializing the database with seed data](#reinitializing-the-database-with-seed-data)

# Introduction: Coolmovies challenge

**You only have to complete the "Challenge" relevant to the role you have applied to.**

**For Frontend Developers, complete the `Web version challenge`.**
**For Mobile Developers, complete the `Mobile version challenge`.**

**Your asssement has to be delivered via Git Bundle, do not upload your solution to public remote repository**

**There are specific instructions on a README in the specific challenge folder**

**Work on this project like you would your normal job. We don't want to see mono-commits and for your commit history to be "First Commit" -> "Project Finished".**

**"First Commit" -> "Add component" -> "Add component" -> "Editing of reviews" -> ... is preferred.**

# Web version challenge

Please take a look at the README inside of `coolmovies-frontend` for the details.

# Mobile version challenge

Please take a look at the README inside of `coolmovies-mobile` for the details.

## Requirements

- Docker, a recent version (>= 20)
- Docker Compose (one compatible with above docker)
- Your local ports 5432 and 5001 are free (not running another postgres server, for instance)

You need docker and docker compose installed on your machine. It supports Linux, MacOS and Windows.

If it's your first time, you can follow the official instructions:
https://docs.docker.com/desktop/
https://docs.docker.com/compose/install/

## Running the server

    cd coolmovies-backend
    docker-compose up

Wait for a log message like this: `PostGraphile v4.12.3 server listening on port 5000` (just keep in mind that we are going to use port 5001)

Now try to connect to GraphiQL and play around with the schema: http://localhost:5001/graphiql

The actual endpoint to run your queries and mutations: http://localhost:5001/graphql

## Play around with some examples

Now that your backend is working, you can play around with some queries and mutation that we already built as example. Keep in mind that running mutations here you will be actually mutating the data in your backend, but don't worry if you have an accident! In the next section we explain you how to reset your server database.

We are using Insomnia to provide you some examples. If you don't know about Insomnia you can think about it as another Postman application.

You can install Insomnia from here: https://insomnia.rest

Once that you have it running, you can import Insomnia_Collection.json from the `backend` folder.

## Reinitializing the database with seed data

So you were playing with the mutations and deleted something you shouldn't, no problem!

Go to the `coolmovies-backend` folder using your preferred terminal, then:

    docker-compose down
    docker volume rm coolmovies-backend_db
    docker rmi coolmovies-db:latest
    docker-compose up

If you want also to rebuild the Postgraphile Server, run this before the `up` command.

    docker rmi coolmovies-graphql:**latest**

Good luck and have fun!
