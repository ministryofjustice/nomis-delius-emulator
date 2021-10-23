# frozen_string_literal: true

class AddUniqueIndexOnOffenderNo < ActiveRecord::Migration[6.1]
  def change
    change_table :offenders do |t|
      t.index :offenderNo, unique: true
    end
  end
end
