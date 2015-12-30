namespace :deploy do

  desc "Restart Passenger via touch"
  task :restart do
    on roles(:app) do
      execute("sudo passenger-config restart-app #{fetch(:deploy_to)} --ignore-app-not-running")
    end
  end

  after  'symlink:release', 'restart'

end
