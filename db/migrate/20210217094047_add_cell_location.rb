# frozen_string_literal: true

class AddCellLocation < ActiveRecord::Migration[6.0]
  def change
    change_table :offenders do |t|
      t.string :cellLocation
    end
  end
end
