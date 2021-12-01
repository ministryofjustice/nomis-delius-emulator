class AddRestrictedPatientOnOffender < ActiveRecord::Migration[6.1]
  def change
    change_table :offenders do |t|
      t.boolean :restrictedPatient, default: false
      t.rename :cellLocation, :location
    end
  end
end
