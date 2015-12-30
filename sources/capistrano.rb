# run 'bundle exec cap install'

# @repo_owner = ask("Who owns this repo on GitHub?")
@repo_owner = 'foo'

file 'Capfile',
  processed_file('Capfile')

file 'config/deploy.rb',
  processed_file('config/deploy.rb')

file 'config/deploy/staging.rb',
  processed_file('config/deploy/staging.rb')

file 'config/deploy/production.rb',
  processed_file('config/deploy/production.rb')

%w(bounce restart seeds sekrets).each do |task|

  file "lib/capistrano/tasks/#{task}",
    processed_file("lib/capistrano/tasks/#{task}.rake")

end
