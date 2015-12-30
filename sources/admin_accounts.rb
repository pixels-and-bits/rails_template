generate 'devise AdminAccount'

rake 'db:migrate'

file 'db/seeds/development/admin_accounts.rb',
  processed_file('db/seeds/development/admin_accounts.rb')
