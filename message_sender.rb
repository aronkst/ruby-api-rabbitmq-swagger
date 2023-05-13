# frozen_string_literal: true

require 'bunny'

class MessageSender
  def initialize(queue_name)
    @queue_name = queue_name
  end

  def send_message(message_id)
    connection = Bunny.new(hostname: 'rabbitmq')
    connection.start

    channel = connection.create_channel
    queue = channel.queue(@queue_name)

    channel.default_exchange.publish(message_id.to_s, routing_key: queue.name)

    connection.close
  end
end
