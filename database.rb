# frozen_string_literal: true

require 'sequel'

sleep(3)

Sequel.extension :migration

POSTGRES = Sequel.connect('postgres://postgres:postgres@postgres:5432')

POSTGRES.run('DROP DATABASE IF EXISTS ruby_api_rabbitmq_swagger')
POSTGRES.run('CREATE DATABASE ruby_api_rabbitmq_swagger')

POSTGRES.run('DROP DATABASE IF EXISTS ruby_api_rabbitmq_swagger_test')
POSTGRES.run('CREATE DATABASE ruby_api_rabbitmq_swagger_test')

POSTGRES.disconnect

RUBY_API_RABBITMQ_SWAGGER = Sequel.connect('postgres://postgres:postgres@postgres:5432/ruby_api_rabbitmq_swagger')
Sequel::Migrator.run(RUBY_API_RABBITMQ_SWAGGER, './migrations', use_transactions: true)

RUBY_API_RABBITMQ_SWAGGER_TEST = Sequel.connect('postgres://postgres:postgres@postgres:5432/ruby_api_rabbitmq_swagger_test')
Sequel::Migrator.run(RUBY_API_RABBITMQ_SWAGGER_TEST, './migrations', use_transactions: true)

RUBY_API_RABBITMQ_SWAGGER.disconnect
RUBY_API_RABBITMQ_SWAGGER_TEST.disconnect
