namespace :deploy do

  desc "Bounce the DB"
  task :bounce do
    if 'production' == fetch(:stage)
      puts 'Nope, not bouncing production!'
      exit(1)
    end

    on primary fetch(:migration_role) do
      execute("cd #{release_path} && sudo apachectl stop && sudo /etc/init.d/postgresql restart && RAILS_ENV=#{fetch(:stage)} bundle exec rake db:bounce && sudo apachectl start")
    end

  end

end
