Account.where(email: 'test@example.com').first_or_create!(
  password: 'password'
)
