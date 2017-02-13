require 'sprockets'
require 'uglifier'
require 'sass'
require 'execjs'

module Sinatra
  module Rider
    module AssetPipeline
      def self.registered(app)
        app.set :pipeline, Sprockets::Environment.new

        app.pipeline.append_path "assets/stylesheets"
        app.pipeline.js_compressor  = :uglify
        app.pipeline.css_compressor = :scss

        app.get "/assets/*" do
          env["PATH_INFO"].sub!("/assets", "")
          settings.pipeline.call(env)
        end
      end
    end
  end
end
