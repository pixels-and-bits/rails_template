namespace :db do

  desc "Pull the database down"
  task :pull do
    require 'etc'

    dumpdir = File.join(Dir.pwd, 'tmp', 'db_dumps', Etc.getlogin)
    remote_path = ''
    local_path = ''

    FileUtils.mkdir_p(dumpdir)

    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          remote_path = capture(:rake, "db:dump\[#{Etc.getlogin}\]").strip
        end
      end

      local_path = File.join(dumpdir, File.basename(remote_path))

      download! remote_path, local_path
    end

    run_locally do
      system("bundle exec rake db:drop db:create db:load[#{local_path}]")
    end

    on primary fetch(:migration_role) do
      within release_path do
        execute :rm, remote_path
      end
    end

    if yesno('Remove the downloaded file?')
      system("rm #{local_path}")
    end

  end

end

def yesno(prompt = 'Continue?', default = true)
  a = ''
  s = default ? '[Y/n]' : '[y/N]'
  d = default ? 'y' : 'n'
  until %w[y n].include? a
    a = HighLine.new.ask("#{prompt} #{s} ") { |q| q.limit = 1; q.case = :downcase }
    a = d if a.length == 0
  end
  a == 'y'
end
