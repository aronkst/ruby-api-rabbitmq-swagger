# frozen_string_literal: true

require 'rack/test'
require 'rspec'
require_relative '../server'

describe 'Server' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe 'GET /' do
    context 'when there are no messages' do
      it 'returns an empty array' do
        get '/'
        expect(last_response.status).to eq(200)
        expect(last_response.body).to eq('[]')
      end
    end

    context 'when there are messages' do
      let(:message1) { Message.create(content: 'Hello, world!') }
      let(:message2) { Message.create(content: 'How are you?') }
      let(:messages) { Message.all }

      it 'returns all messages' do
        get '/'
        expect(last_response.status).to eq(200)
        expect(last_response.body).to eq(messages.to_json)
      end
    end
  end

  describe 'POST /' do
    context 'with valid params' do
      let(:params) { { content: 'test message' } }

      it 'creates a new message' do
        expect_any_instance_of(MessageSender).to receive(:send_message)

        post '/', params.to_json
        expect(last_response.status).to eq(201)
        expect(JSON.parse(last_response.body)).to include('id', 'content')
      end
    end

    context 'with invalid params' do
      let(:params) { { content: '' } }

      it 'returns validation errors' do
        post '/', params.to_json
        expect(last_response.status).to eq(400)
        expect(JSON.parse(last_response.body)).to include('content' => ['is shorter than 1 characters'])
      end
    end
  end

  describe 'GET /:id' do
    context 'when the message exists' do
      let(:message) { Message.create(content: 'test get message') }

      it 'returns the message' do
        get "/#{message.id}"
        expect(last_response.status).to eq(200)
        expect(last_response.body).to eq(message.to_json)
      end
    end

    context 'when the message does not exist' do
      it 'returns a 404 error' do
        get '/9999'
        expect(last_response.status).to eq(404)
        expect(JSON.parse(last_response.body)).to include('error' => 'Message with ID 9999 not found')
      end
    end
  end
end
