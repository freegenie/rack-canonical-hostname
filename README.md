# Rack::CanonicalHost

Use this rack module if you want to have your application respond to just 
one domain name and redirect any other the domain. 

For example when your applicaiton responds to both www and non www prefixed 
domain name, or to both www.mysite.org and mysite.herokuapp.com. 

Redirect preserves path and querystring.

## Installation

Add this line to your application's Gemfile:

    gem 'rack-canonical-host', :require => 'rack/canonical_host'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-canonical-host

## Usage

Configure three options: 

  * host: the actual canonical host name for your site 
  * scheme: redirect to http or https. Default to http
  * ignore: an array of hostnames to ignore 

Example for rails configuration: 

```
  config.middleware.insert_before Rack::Lock, Rack::CanonicalHost, {
    :host   => 'my-site.com',
    :scheme => 'https',
    :ignore => ['staging.my-site.com', 'balabik-staging.herokuapp.com']
  }
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
