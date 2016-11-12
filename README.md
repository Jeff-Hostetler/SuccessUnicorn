# Success Unicorn

## Why use me?
When your test pass a friggin unicorn prints in your terminal/IDE. If they fail, a spooky
bat will scare you to encourage you to go green.

## How to use me?
Add to your gemfile in development
```
group :test, :development do
  gem "success_unicorn"
end
```

In your rails_helper file, add Success Unicorn as a dependency and to your configuration.
See on RubyGems https://rubygems.org/gems/SuccessUnicorn. 

```
require "success_unicorn"
```

```
RSpec.configure do |config|
  #other configuration stuff

  config.after(:suite) do
    examples = RSpec.world.filtered_examples.values.flatten
    SuccessUnicorn::MessageGenerator.generate(examples)
  end
end
```

