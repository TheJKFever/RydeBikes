Rails.application.configure do

  # Braintree
  Braintree::Configuration.environment = ENV['RYDE_BRAINTREE_ENVIRONMENT'].to_sym
  Braintree::Configuration.merchant_id = ENV['RYDE_BRAINTREE_MERCHANT_ID']
  Braintree::Configuration.public_key = ENV['RYDE_BRAINTREE_PUBLIC_KEY']
  Braintree::Configuration.private_key = ENV['RYDE_BRAINTREE_PRIVATE_KEY']

end

