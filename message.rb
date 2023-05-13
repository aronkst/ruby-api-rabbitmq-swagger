# frozen_string_literal: true

require 'sequel'

DB = Sequel.connect('postgres://postgres:postgres@postgres:5432/ruby_api_rabbitmq_swagger')

class Message < Sequel::Model
  plugin :json_serializer
  plugin :validation_helpers

  set_primary_key [:id]

  def validate
    super
    validates_min_length 1, :content
  end
end
