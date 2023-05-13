# frozen_string_literal: true

require 'bunny'
require_relative 'message'

class MessageReceiver
  def initialize(queue_name)
    @queue_name = queue_name
  end

  def receive_messages
    connection = Bunny.new(hostname: 'rabbitmq')
    connection.start

    channel = connection.create_channel
    queue = channel.queue(@queue_name)

    begin
      queue.subscribe(block: true) do |_delivery_info, _properties, body|
        message = Message.first(id: body.to_i)
        message.status = true
        message.save
      end
    rescue StandardError
      connection.close
    end
  end
end
