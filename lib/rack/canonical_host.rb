module Rack
  class CanonicalHost 

    VERSION = 0.1 

    def initialize(app, options = {}) 
      @app    = app
      @host   = options.fetch(:host)
      @scheme = options.fetch(:scheme) { 'http' }
      @ignore = options.fetch(:ignore) { [] }
    end


    def request_host 
      @env['HTTP_HOST'].split(':').first
    end

    def call(env)
      @env = env 
      if request_host != @host && !@ignore.include?(request_host)
        uri        = URI.parse ''
        uri.host   = @host
        uri.query  = env['QUERY_STRING'] || ''
        uri.path   = env['REQUEST_PATH'] || ''
        uri.scheme = @scheme

        status  = 301 
        headers = {'Location' => uri.to_s, 'Content-Type' => 'text/plain'}
        body    = ["Redirecting to canonical URL #{uri}"]

        [status, headers, body]
      else 
        @app.call(env)
      end
    end
  end
end
