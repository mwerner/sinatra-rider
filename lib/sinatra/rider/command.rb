require 'thor'

module Sinatra
  module Rider
    class Generator < Thor::Group
      include Thor::Actions

      argument :path
      def new
        # generate application
      end

      def prepare_dokku
        create_file("#{path}/CHECKS") { "/ #{path.capitalize}\n" }
        create_file("#{path}/DOKKU_SCALE") { "web=1\n" }
      end

      def prepare_ruby_version
        create_file("#{path}/.ruby-version") { "2.1.9\n" }
      end

      def prepare_dotenv
        create_file("#{path}/.env") { "SESSION_SECRET=super secret shh\n" }
        create_file("#{path}/.gitignore") { ".env\n" }
      end

      def prepare_database
        template('templates/database.erb', "#{path}/config/database.yml")
        template('templates/users_migration.erb', "#{path}/db/migrate/1_create_users.rb")
      end

      def prepare_rack
        template('templates/gemfile.tt', "#{path}/Gemfile")
        template('templates/procfile.tt', "#{path}/Procfile")
        template('templates/rakefile.tt', "#{path}/Rakefile")
        template('templates/rackup.tt', "#{path}/config.ru")
        template('templates/server.tt', "#{path}/server.rb")
      end

      def prepare_app
        template('templates/user.tt', "#{path}/app/user.rb")
        template('templates/layout.erb', "#{path}/views/layout.erb")
        template('templates/navigation.erb', "#{path}/views/_navigation.erb")
        template('templates/index.erb', "#{path}/views/index.erb")
      end

      def prepare_assets
        create_file "#{path}/assets/javascripts/application.js"

        create_file "#{path}/assets/stylesheets/vendor/.keep"
        create_file("#{path}/assets/stylesheets/base.scss") { "body {}" }
        template('templates/css.tt', "#{path}/assets/stylesheets/application.scss")
      end

      def self.source_root
        File.dirname(__FILE__)
      end
    end

    class Command < Thor
      register(Sinatra::Rider::Generator, 'new', 'new', 'Create a new sinatra-rider application at PATH_NAME')
    end
  end
end
