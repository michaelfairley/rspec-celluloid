# Rspec::Celluloid

Run your RSpec suite in parallel on top of [Celluloid](https://github.com/celluloid/celluloid).

## Installation

Add this line to your application's Gemfile:

    gem 'rspec-celluloid'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-celluloid

## Usage

Use `crspec` instead of `rspec` to run your test suite.

## TODO:

- Add a rake task like RSpec::Core::RakeTask.
- Open a PR on rspec-core to make this project less monkey-patchy and not have to require its own executable.
- Figure out how to best size the actor pool. Defaults to #CPUs, which is probably too few for the average IO bound project.
- Figure out better ways to test this.
- Restrict the formatters that can be used ("documentation" and others will have major issues running concurrently).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
