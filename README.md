# BacklogApi

Ruby toolkit for the Backlog API.

## Installation

Add this line to your application's Gemfile:

    gem 'backlog_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install backlog_api

## Usage

### Get timeline
```ruby
require 'backlog_api'
client = BacklogApi::Client.new
client.get_timeline
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
