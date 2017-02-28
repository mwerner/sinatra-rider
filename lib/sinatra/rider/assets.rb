require 'sprockets'
require 'uglifier'
require 'sass'
require 'execjs'

module Sinatra
  module Rider
    module Assets
      def self.registered(app)
        app.set :pipeline, pipeline = Sprockets::Environment.new

        pipeline.append_path "assets/stylesheets"
        pipeline.append_path "assets/javascripts"
        pipeline.append_path File.join(__dir__, "views/vendor")

        pipeline.js_compressor  = :uglify
        pipeline.css_compressor = :scss

        app.get '/assets/*' do
          env['PATH_INFO'].sub!(%r{^/assets}, '')
          pipeline.call(env)
        end

        app.configure :development do
          pipeline.cache = Sprockets::Cache::FileStore.new(File.join(app.root, 'tmp'))
        end
      end
    end
  end
end
