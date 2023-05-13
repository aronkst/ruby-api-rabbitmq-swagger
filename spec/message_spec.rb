# frozen_string_literal: true

require_relative '../message'

RSpec.describe Message do
  before do
    allow(ENV).to receive(:fetch).and_return('ruby_api_rabbitmq_swagger_test')
  end

  describe 'validations' do
    context 'when content is present' do
      it 'is valid' do
        message = Message.new(content: 'Hello, world!')
        expect(message.valid?).to be true
      end
    end

    context 'when content is blank' do
      it 'is invalid' do
        message = Message.new(content: '')
        expect(message.valid?).to be false
      end
    end
  end
end
