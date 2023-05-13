# frozen_string_literal: true

require 'bunny'
require_relative '../message'
require_relative '../message_receiver'

RSpec.describe MessageReceiver do
  describe '#receive_messages' do
    let(:queue_name) { 'test_queue' }

    it 'should subscribe to the queue and update message status' do
      message_receiver = MessageReceiver.new(queue_name)
      message = Message.create(content: 'test', status: false)

      expect_any_instance_of(Bunny::Queue).to receive(:subscribe).with(block: true).and_yield(nil, nil, message.id.to_s)
      expect { message_receiver.receive_messages }.to change { message.reload.status }.from(false).to(true)
    end

    it 'should close the connection when an error occurs' do
      message_receiver = MessageReceiver.new(queue_name)

      allow_any_instance_of(Bunny::Queue).to receive(:subscribe).and_raise(StandardError)
      expect_any_instance_of(Bunny::Session).to receive(:close)

      message_receiver.receive_messages
    end
  end
end
