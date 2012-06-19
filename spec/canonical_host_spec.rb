require 'rack/mock'
require_relative '../lib/rack/canonical_host' 

describe Rack::CanonicalHost do 
  let(:simple_app) do 
    lambda {|env| [200, {'Content-type' => 'text/html'}, ['Hello Rack'] ] }
  end

  context 'with canonical host at test.example.org' do 
    let(:app) do 
      Rack::CanonicalHost.new(simple_app, 
                              :scheme => 'https', 
                              :host => 'test.example.org', 
                              :ignore => ['ignore.example.org']
                             )
    end

    it 'should pass if domain name is canonical' do 
      response = Rack::MockRequest.new(app)
        .get('/', {'HTTP_HOST' => 'test.example.org'})

      response.status.should == 200
    end

    it 'should redirect if domain name is not canonical' do
      response = Rack::MockRequest.new(app)
        .get('/', {'HTTP_HOST' => 'foo.example.org'})

      response.status.should == 301
    end

    it 'should redirect with path' do
      response = Rack::MockRequest.new(app)
        .get('/', {
          'HTTP_HOST' => 'foo.example.org',
          'PATH_INFO' => '/login'
        })

      response.headers['Location'].should =~ /\/login/ 
    end

    it 'should redirect with query string' do 
      response = Rack::MockRequest.new(app)
        .get('/', {
          'HTTP_HOST' => 'foo.example.org',
          'PATH_INFO' => '/login', 
          'QUERY_STRING' => 'a=10&b=20'
        })

      response.headers['Location'].should =~ /\?a=10&b=20/ 
    end

    it 'should redirect with scheme' do 
      response = Rack::MockRequest.new(app)
        .get('/', {
          'HTTP_HOST' => 'foo.example.org',
        })

      response.headers['Location'].should =~ /https:\/\//
    end

    it 'should not redirect if host is in ignore list' do 
      response = Rack::MockRequest.new(app)
        .get('/', {
          'HTTP_HOST' => 'ignore.example.org',
        })

      response.status.should == 200
    end

  end
end
