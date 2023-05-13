# frozen_string_literal: true

require 'json'
require 'sinatra'
require_relative 'message'
require_relative 'message_sender'

set :port, 3000

before do
  content_type :json
end

get '/' do
  messages = Message.all
  messages.to_json
end

post '/' do
  content = JSON.parse(request.body.read)['content']
  message = Message.new(content:)
  message.save

  MessageSender.new('messages').send_message(message.id.to_s)

  status 201
  message.to_json
rescue StandardError
  status 400
  message.errors.to_json
end

get '/:id' do
  message = Message.first(id: params[:id].to_i)
  if message
    message.to_json
  else
    status 404
    { error: "Message with ID #{params[:id]} not found" }.to_json
  end
end
