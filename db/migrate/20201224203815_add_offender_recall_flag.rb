# frozen_string_literal: true

class AddOffenderRecallFlag < ActiveRecord::Migration[5.2]
  def change
    change_table :offenders do |t|
      t.boolean :recall_flag, null: false, default: false
    end
  end
end
