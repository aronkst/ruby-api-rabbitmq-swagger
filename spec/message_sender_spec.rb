# frozen_string_literal: true

require_relative '../message_sender'

RSpec.describe MessageSender do
  let(:queue_name) { 'test_queue' }
  let(:message_id) { 123 }

  describe '#send_message' do
    context 'when RabbitMQ connection is successful' do
      it 'publishes the message to the queue' do
        message_sender = MessageSender.new(queue_name)

        expect_any_instance_of(Bunny::Exchange).to receive(:publish).with(message_id.to_s, routing_key: queue_name)

        message_sender.send_message(message_id)
      end

      it 'closes the connection' do
        message_sender = MessageSender.new(queue_name)

        expect_any_instance_of(Bunny::Session).to receive(:close)

        message_sender.send_message(message_id)
      end
    end
  end
end
