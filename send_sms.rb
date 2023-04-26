require 'rubygems'
require 'twilio-ruby'
require 'dotenv/load'

# Rails models
# require_relative './config/environment'

# Get infos from database
user = User.find(Customer.first.user_id) # Remplacez 'Customer.first' par la logique nécessaire pour trouver le bon client
order = Order.last # Remplacez 'Order.last' par la logique nécessaire pour trouver la bonne commande

# Message to send
message_body = "Hello is on its way!"

account_sid = ENV['TWILIO_ACCOUNT_SID']
auth_token = ENV['TWILIO_AUTH_TOKEN']
@client = Twilio::REST::Client.new(account_sid, auth_token)

message = @client.messages
  .create(
     body: message_body,
     from: '+16812216638',
     to: '+14182786747'
   )

puts message.sid
