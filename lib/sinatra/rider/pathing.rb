module Sinatra
  module Rider
    module Pathing
      def self.registered(app)
        app.set :views, [app.settings.views, File.join(File.dirname(__dir__), 'views')]

        app.helpers do
          def find_template(views, name, engine, &block)
            [*views].each { |v| super(v, name, engine, &block) }
          end
        end
      end
    end
  end
end
