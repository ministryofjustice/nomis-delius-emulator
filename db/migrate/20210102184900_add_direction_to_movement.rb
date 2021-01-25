# frozen_string_literal: true

class AddDirectionToMovement < ActiveRecord::Migration[5.2]
  def change
    change_table :movements do |t|
      t.string :directionCode, limit: 3
    end
  end
end
