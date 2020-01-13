# Omniauth::Netlify

[![Travis-CI](https://travis-ci.org/fnando/omniauth-netlify.svg)](https://travis-ci.org/fnando/omniauth-netlify)
[![CodeClimate](https://codeclimate.com/github/fnando/omniauth-netlify.svg)](https://codeclimate.com/github/fnando/omniauth-netlify)
[![Test Coverage](https://codeclimate.com/github/fnando/omniauth-netlify/badges/coverage.svg)](https://codeclimate.com/github/fnando/omniauth-netlify/coverage)
[![Gem](https://img.shields.io/gem/v/omniauth-netlify.svg)](https://rubygems.org/gems/omniauth-netlify)
[![Gem](https://img.shields.io/gem/dt/omniauth-netlify.svg)](https://rubygems.org/gems/omniauth-netlify)

[Netlify](http://netlify.com)'s OAuth2 Strategy for OmniAuth.

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-netlify'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-netlify

## Usage

`OmniAuth::Strategies::Netlify` is simply a Rack middleware. Read the OmniAuth docs for detailed instructions: <https://github.com/intridea/omniauth>.

First, create a new application at `https://app.netlify.com/user/applications#oauth`. Your callback URL must be something like `https://example.com/auth/netlify/callback`. For development you can use `http://127.0.0.1:3000/auth/netlify/callback`.

Here's a quick example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`. This example assumes you're exporting your credentials as environment variables.

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :netlify,
            ENV['NETLIFY_CLIENT_ID'],
            ENV['NETLIFY_CLIENT_SECRET']
end
```

Now visit `/auth/netlify` to start authentication against Netlify.

## Contributing

1. Fork [omniauth-netlify](https://github.com/fnando/omniauth-netlify/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
