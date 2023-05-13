# frozen_string_literal: true

require 'simplecov'
require 'sequel'
require_relative '../message'

SimpleCov.start

DB = Sequel.connect('postgres://postgres:postgres@postgres:5432/ruby_api_rabbitmq_swagger_test')

RSpec.configure do |config|
  config.after(:each) { Message.all.each(&:delete) }
  config.around(:each) do |example|
    DB.transaction(rollback: :always, auto_savepoint: true) { example.run }
  end
end
