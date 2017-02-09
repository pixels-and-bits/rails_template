# @repo_owner = ask("Who owns this repo on GitHub?")

file 'Capfile',
  processed_file('Capfile')

file 'config/deploy.rb',
  processed_file('config/deploy.rb')

file 'config/deploy/staging.rb',
  processed_file('config/deploy/staging.rb')

file 'config/deploy/production.rb',
  processed_file('config/deploy/production.rb')


%w(
  lib/capistrano/tasks/bounce.rake
  lib/capistrano/tasks/db.rake
  lib/capistrano/tasks/seeds.rake
).each do |task|

  file task,
    processed_file(task)

end
