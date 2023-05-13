# frozen_string_literal: true

require 'bunny'

Sequel.migration do
  up do
    create_table(:messages) do
      primary_key :id
      String :content, null: false
      Boolean :status, default: false, null: false
    end
  end

  down do
    drop_table(:messages)
  end
end
