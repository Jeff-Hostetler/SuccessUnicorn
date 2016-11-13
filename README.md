# Success Unicorn

## Why use me?
When your test pass a friggin unicorn prints in your terminal/IDE. If they fail, a spooky
bat will scare you to encourage you to go green.
See on RubyGems https://rubygems.org/gems/success-unicorn.

## How to use me?
Add to your gemfile in development
```
group :test, :development do
  gem "success_unicorn"
end
```
### In your rails_heler
In your rails_helper file, add Success Unicorn as a dependency and to your configuration.

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

### Rake support

If you are running your suite through rake, you can capture the bash exit object and pass that along
to SuccessUnicorn.

```
Rake::Task["spec"].clear
desc "Run specs"
task :spec do |_, args|
  system "bundle exec rspec"
  SuccessUnicorn::MessageGenerator.generate_for_exit_status($?.exitstatus)
end
```
