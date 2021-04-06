[![Gem Version](https://badge.fury.io/rb/capistrano-racecar.svg)](http://badge.fury.io/rb/capistrano-racecar)

# Capistrano::Racecar

Sidekiq integration for Capistrano

## Installation

    gem 'capistrano-racecar', group: :development

And then execute:

    $ bundle


## Usage
```ruby
# Capfile
 
require 'capistrano/racecar'

install_plugin Capistrano::Racecar
```


Configurable options, shown here with defaults:

```ruby
set_if_empty :racecar_task_path, 'config/racecar_task.yml'
set_if_empty :racecar_role, :app
set_if_empty :racecar_user, :system
set_if_empty :racecar_ctl, 'bundle exec racecarctl'
set_if_empty :racecar_pid_path, "#{fetch(:deploy_to)}/shared/tmp/pids"
```


## Bundler

If you'd like to prepend `bundle exec` to your racecar calls, modify the SSHKit command maps
in your deploy.rb file:
```ruby
SSHKit.config.command_map[:sidekiq] = "bundle exec sidekiq"
SSHKit.config.command_map[:sidekiqctl] = "bundle exec sidekiqctl"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
