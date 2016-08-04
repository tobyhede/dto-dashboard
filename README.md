# Dashboard

Version 3.0 of the Performance Dashboard.

Currently WIP.


## Requirements

 - ruby-2.3.1
 - Postgres 9.4


## Getting Started

### Database

The default database config assumes you have installed Postgres via Homebrew.
You should need no further config.

Otherwise, create a `.env` file in the Rails directory and populate with the relevant credentials.

```
DB_HOST = '127.0.0.1'
DB_USER_NAME = 'dashboard'
DB_PWD = 'password'
```

Create a database

```
rake db:create
```

Migrate the database

```
rake db:migrate
```

### Run the App

To run on the default port (3000)
```
rails server
```

The site can now be viewed at `http://localhost:3000/`


## Tests

```
rspec
```
