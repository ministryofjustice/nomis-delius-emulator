# frozen_string_literal: true

class AddKeyWorkerToOffender < ActiveRecord::Migration[5.2]
  def change
    change_table :offenders do |t|
      t.bigint :keyworker_id
    end
  end
end
