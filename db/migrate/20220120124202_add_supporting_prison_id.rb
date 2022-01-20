# frozen_string_literal: true

class AddSupportingPrisonId < ActiveRecord::Migration[6.1]
  def change
    change_table :offenders do |t|
      t.string :supportingPrisonId, default: "LEI"
    end
  end
end
