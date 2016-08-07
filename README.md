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



## High-level Development Process

## TL;DR​

1. Branch

2. PR

3. Review

4. Merge



### Branch Often.

 All work should be on a branch. Discretion is accepted for small changes.

 Rebase long-living branches often (on master).


 ### Branch Naming Conventions

 For extra points name the branch to annotate the type of work and ticket number being resolved.
 ​
 Examples;
 ​

 - `bugfix/477-broken-redirects-for-guests`

 - `feature/502-new-cart-logo`

 - `ops/808-cloud-66-postgres-tweaks`

 ​

 #### Types of branches

 ​
 ```

 feature -> feature

 fix     -> fix

 ops     -> infrastructure / ops related changes

 test    -> adding missing tests

 tweak   -> small changes, documentation, refactors

 ```

 ## PR

 - Merges should be managed using a Pull Request

 - Before finishing a PR, rebase on master

 - Create the PR early and label as `WIP`


 ### Review


 - At least one other person should review the PR before merge.

 - A review should ideally involve actually checking out and running the code, and sanity checking it before merge.

 - Close any related issues​ in Jira
