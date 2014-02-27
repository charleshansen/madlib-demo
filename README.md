madlib-demo
===========
Prerequisites: Postgres 9.1 or Postgres 9.2
MADlib needs to run alongside your database and needs superuser db credentials.
Currently MADlib 1.4 is not supported by HAWQ/Pivotal HD 1.1. The newer version of MADlib should
be compatible with HAWQ/Pivotal HD 1.2. Then this app can be deployed using HAWQ/Pivotal HD as a
persistence layer on cloud foundry. The current solution we turned to as a workaround is to deploy
a postgres server on an EC2 instance.

Because switching to an older postgres can be difficult if you have a newer version, the basic steps are here:

    pg_ctl stop -D /usr/local/var/postgres/
    brew tap homebrew/versions
    brew install homebrew/versions/postgresql92
    chmod 764 postgresql92/9.2.6/homebrew.mxcl.postgresql92.plist
    /usr/local/Cellar/postgresql92/9.2.6/bin/initdb -D /usr/local/var/postgres92/
    pg_ctl start -D /usr/local/var/postgres92/ -p /usr/local/Cellar/postgresql92/9.2.6/bin/postgres

To install MADlib locally:

    rake db:create
    /usr/local/madlib/bin/madpack -p postgres -c pivotal@localhost/madlib-demo_development install
    /usr/local/madlib/bin/madpack -p postgres -c pivotal@localhost/madlib-demo_development install-check


To seed data:
    rake db:seed

To deploy to cloud foundry (madlib-demo-staging.cfapps.io):
    RAILS_ENV=production rake assets:precompile
    cf push

