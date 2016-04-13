# @repo_owner = ask("Who owns this repo on GitHub?")

file 'Capfile',
  processed_file('Capfile')

file 'config/deploy.rb',
  processed_file('config/deploy.rb')

file 'config/deploy/staging.rb',
  processed_file('config/deploy/staging.rb')

file 'config/deploy/production.rb',
  processed_file('config/deploy/production.rb')

Dir['lib/capistrano/**/*'].each do |task|

  file task,
    processed_file(task)

end
