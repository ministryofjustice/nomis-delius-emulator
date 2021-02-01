# frozen_string_literal: true

class RemoveOffenderGender < ActiveRecord::Migration[6.0]
  def change
    remove_column :offenders, :gender, type: :string, limit: 1, null: false
  end
end
