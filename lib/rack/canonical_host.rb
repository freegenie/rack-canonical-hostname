module Rack
  class CanonicalHost 
    VERSION = 0.2

    def initialize(app, options = {}) 
      @app    = app
      @host   = options.fetch(:host)
      @scheme = options.fetch(:scheme) { 'http' }
      @ignore = options.fetch(:ignore) { [] }
    end

    def call(env)
      request = rack_request(env)
      
      if request.host != @host && !@ignore.include?(request.host)
        uri = URI.parse request.url
        uri.host   = @host
        uri.scheme = @scheme

        status  = 301 
        headers = {'Location' => uri.to_s, 'Content-Type' => 'text/plain'}
        body    = ["Redirecting to canonical URL #{uri}"]

        [status, headers, body]
      else 
        @app.call(env)
      end
    end

    protected

    def rack_request(env)
      Rack::Request.new(env)
    end
  end
end
