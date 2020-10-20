# frozen_string_literal: true

class CreatePrisons < ActiveRecord::Migration[5.1]
  def change
    create_table :prisons do |t|
      t.string :code, limit: 3, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
