ActionMailer::Base.add_delivery_method(
  :ses,
  AWS::SES::Base,
  access_key_id: ENV.fetch('ACCESS_KEY_ID'),
  secret_access_key: ENV.fetch('SECRET_ACCESS_KEY'),
  server: 'email.us-west-2.amazonaws.com'
)
