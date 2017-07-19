# Plissken

Have you ever needed to automatically convert JSON-style `camelBack` or `CamelCase` hash keys into more Rubyish `snake_case`?

Plissken to the rescue.

This gem recursively converts all camelBack or CamelCase keys in either a Hash structure, or an Array of Hashes, to snake_case.

## Installation

Add this to your Gemfile:

```ruby
gem "plissken"
```

Or install it yourself as:

```bash
gem install plissken
```

## Usage

On hashes:

```ruby
my_hash = { "firstKey" => 1, "fooBars" => [{ "bazBaz" => "value" }, { "blahBlah" => "value" }] }
snaked_hash = my_hash.to_snake_keys
# => { "first_key" => 1, "foo_bars" => [{ "baz_baz" => "value" }, { "blah_blah" => "value" }] }
```

On arrays:

```ruby
my_array_of_hashes = [{ "firstKey" => 1, "fooBars" => [{ "bazBaz" => "value" }, { "blahBlah" => "value" }] }]
snaked_hash = my_array_of_hashes.to_snake_keys
# => [{"first_key" => 1, "foo_bars" => [{ "baz_baz" => "value" }, { "blah_blah" => "value" }] }]
```

Plissken works on either string keys or symbolized keys. It has no dependencies, as it has its own `underscore` method lifted out of ActiveSupport.

## Limitations

* Your keys must be camelBack or CamelCase. The key "Foo Bar" will output as "foo bar".
* Unlike the original Snake Plissken in the seminal film [Escape from New York](http://en.wikipedia.org/wiki/Escape_from_New_York), the plissken gem is non-destructive. There is no `Hash#to_snake_keys!` form.

# Going the other way

If you've already got `snake_case` and need to `CamelCase` it, you are encouraged to try
the [Awrence](http://github.com/futurechimp/awrence) gem.

## Contributing to plissken

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2017 Dave Hrycyszyn. See LICENSE.txt for
further details.
