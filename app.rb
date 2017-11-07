require 'sinatra'
require 'sinatra/reloader'
require 'sendgrid-ruby'
require 'pry'

include SendGrid

get '/' do
 erb :index
end

get '/about' do
  erb :about
end

get '/product' do
  erb :product
end



get '/contact' do
  erb :contact
end

post '/' do

  from = Email.new(email: params['email'])
  to = Email.new(email: 'mahammad1000@icloud.com')
  subject = 'Sending with SendGrid is Fun'
  content = Content.new(type: 'text/plain', value: params['body'])
  mail = Mail.new(from, subject, to, content)
  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  puts response.body
  puts response.headers

  erb :index
end
