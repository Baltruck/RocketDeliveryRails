require 'rubygems'
require 'twilio-ruby'
require 'dotenv/load'


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
