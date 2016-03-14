# Commonsense

Validate text against the [commonsense specification](https://github.com/beneills/commonsense-spec.) to resist authorship analysis.  See the spec for more information.

This gem contains a Ruby library and single executable.

## Usage

    $ gem install commonsense
    $ commonsense thomas_paine.txt

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec commonsense` to use the gem in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Todo

+ allow verb conjugates
+ add feature to publish to anonymous pastebins

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/beneills/commonsense-gem
