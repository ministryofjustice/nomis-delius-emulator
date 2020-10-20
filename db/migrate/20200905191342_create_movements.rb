# frozen_string_literal: true

class CreateMovements < ActiveRecord::Migration[5.2]
  def change
    create_table :movements do |t|
      t.references :offender, null: false
      t.bigint :from_prison_id
      t.bigint :to_prison_id
      t.string :typecode, limit: 3, null: false

      t.timestamps
    end
  end
end
