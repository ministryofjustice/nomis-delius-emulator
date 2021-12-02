# frozen_string_literal: true

class AddRestrictedPatientLocation < ActiveRecord::Migration[6.1]
  def change
    change_table :offenders do |t|
      t.string :dischargedHospitalDescription
      t.rename :location, :cellLocation
    end
  end
end
