class CreateOffenders < ActiveRecord::Migration[5.1]
  def change
    create_table :offenders do |t|
      t.references :prison, null: false
      t.string :gender, limit: 1
      t.string :categoryCode
      t.string :mainOffence
      t.date :receptionDate
      t.string :firstName
      t.string :lastName
      t.string :offenderNo
      t.string :convictedStatus
      t.string :imprisonmentStatus
      t.date :dateOfBirth

      t.timestamps
    end
  end
end
