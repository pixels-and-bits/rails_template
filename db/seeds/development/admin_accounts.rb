AdminAccount.where(email: 'admin@example.com').first_or_create!(
  password: 'password'
)
