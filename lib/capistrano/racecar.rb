require 'capistrano/bundler'
require 'capistrano/plugin'

module Capistrano
  class Racecar < Capistrano::Plugin
    def define_tasks
      eval_rakefile File.expand_path('../tasks/racecar.rake', __FILE__)
    end

    def set_defaults
      set_if_empty :racecar_task_path, 'config/racecar_task.yml'
      set_if_empty :racecar_role, :app
      set_if_empty :racecar_user, :system
      set_if_empty :racecar_ctl, 'bundle exec racecarctl'
      set_if_empty :racecar_pid_path, "#{fetch(:deploy_to)}/shared/tmp/pids"
    end
  end
end
