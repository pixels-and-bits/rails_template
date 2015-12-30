generate 'devise Account'

rake 'db:migrate'

file 'db/seeds/development/accounts.rb',
  processed_file('db/seeds/development/accounts.rb')
