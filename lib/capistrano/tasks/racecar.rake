git_plugin = self

namespace :deploy do
  before :starting, :check_racecar_hooks do
    invoke 'racecar:add_hooks'
  end
end

namespace :racecar do
  def consumer_list
    YAML.parse_file(fetch(:racecar_task_path)).to_ruby['tasks']
  end

  def build_pid_file(consumer_name)
    "#{fetch(:racecar_pid_path)}/#{consumer_name.downcase}.pid"
  end

  task :add_hooks do
    after 'deploy:updated', 'racecar:stop'
    after 'deploy:published', 'racecar:start'
    after 'deploy:failed', 'racecar:restart'
  end

  desc 'Test'
  task :test do
    on roles(fetch(:racecar_role)) do |role|
      within release_path do
        with rails_env: fetch(:rails_env) do
          info fetch(:racecar_pid_path)
          git_plugin.consumer_list.each { |item|
            git_plugin.build_pid_file(item)
          }
        end
      end
    end
  end

  desc 'Start'
  task :start do
    on roles(fetch(:racecar_role)) do |role|
      within current_path do
        with rails_env: fetch(:rails_env) do
          git_plugin.consumer_list.each do |item|
            execute(:bundle, "exec racecar --daemonize #{item} --pidfile #{git_plugin.build_pid_file(item)} --log log/racecar.log")
          end
        end
      end
    end
  end

  task :stop do
    on roles(fetch(:racecar_role)) do |role|
      within current_path do
        with rails_env: fetch(:rails_env) do
          git_plugin.consumer_list.each do |item|
            execute(:bundle, "exec racecarctl stop --pidfile #{git_plugin.build_pid_file(item)}")
          end
        end
      end
    end
  end

  task :restart do
    invoke! 'racecar:stop'
    invoke! 'racecar:start'
  end

end

