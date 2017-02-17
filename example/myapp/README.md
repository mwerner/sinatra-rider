To get up and running:

```
bundle exec rake db:create db:migrate db:seed
bundle exec rackup config.ru
```

Then visit http://localhost:9292

You should see a login form. You can log in with:

```
username: admin
password: hunter1
```

Have fun!
