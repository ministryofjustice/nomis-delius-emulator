# frozen_string_literal: true

class CreateOffenders < ActiveRecord::Migration[5.1]
  def change
    create_table :offenders do |t|
      t.references :prison, null: false
      t.string :offenderNo, limit: 7, null: false
      t.string :gender, limit: 1, null: false
      t.string :categoryCode
      t.string :mainOffence
      t.date :receptionDate
      t.string :firstName
      t.string :lastName
      t.string :imprisonmentStatus
      t.date :dateOfBirth

      t.timestamps
    end
  end
end
