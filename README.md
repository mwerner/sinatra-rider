# Sinatra::Rider

All the nice extras Sinatra likes to have when he's on the road.

## Including:

- ActiveRecord
- Warden
- Sass
- Dotenv
- Better Errors
- Autoloading `app` and `lib` directories
- ~One dozen blue M&Ms~

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sinatra-rider'
```

Then require it at the top of your server file and register the rider in Sinatra.

```
require 'sinatra/rider'
class Server < Sinatra::Base
  register Sinatra::Rider

  get '/' do
    authorize!
    erb :index
  end
end

run Server
```

That's it!

## Usage

`Sinatra::Rider` provides a quite a few small conveniences.

### ActiveRecord

Activerecord is included and integrated into Sinatra. `Sinatra::Rider` looks for your `database.yml` file in the top level `config` directory. By default Sinatra::Rider uses postgres as its data store via the `pg` gem. This can be changed by including the necessary gem for your data store of choice and configuring your `database.yml` accordingly.

[More Information](https://github.com/janko-m/sinatra-activerecord)

### Warden

Warden is used for authentication. `Sinatra::Rider` sets up Sinatra with `/login` and `/logout` routes. Make sure to set a `SESSION_SECRET` environment variable to properly handle session data.

You can require authentication for an endpoint by including `authorize!` in sinatra's endpoint block

```
get '/' do
  authorize!
  erb :index
end
```

[More Information](https://github.com/jsmestad/sinatra_warden)

### Sass

Sass is handled by Sprockets. `Sinatra::Rider` looks for any assets in `assets/stylesheets` and `assets/javascripts` and compiles them as requested.

```
# assets/stylesheets/application.scss
//= require_tree ./vendor
//= require base

# views/layout.erb
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" type="text/css" href="/assets/application.css">
</head>
<body>

</body>
</html>
```

More Information: [Sass](http://sass-lang.com/) & [Sprockets](https://github.com/rails/sprockets)

### Dotenv

`Sinatra::Rider` will load any environment variables you have present in a top level `.env` file. This is very useful when using secrets or configuration if you're aiming for [12factor](https://12factor.net/).

[More Information](https://github.com/bkeepers/dotenv)

### Better Errors

Better Errors are included in the Sinatra configuration when `RACK_ENV` is in development mode. This makes debugging much easier as it provides better context as well as a REPL at the point of the error.


[More Information](https://github.com/charliesome/better_errors)

### Autoloading `app` and `lib`

Any ruby files present in `app` or `lib` as siblings in the root directory of your `config.ru` will be automatically required.

```
- app # Autoloaded
- config
- lib # Autoloaded
- views
.ruby-version
config.ru
Gemfile
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

