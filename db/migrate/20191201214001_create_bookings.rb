class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.references :offender, null: false
      t.date :home_detention_curfew_eligibility_date
      t.date :parole_eligibility_date
      t.date :release_date
      t.date :automatic_release_date
      t.date :conditional_release_date
      t.date :sentence_start_date
      t.date :tariff_date

      t.timestamps
    end
  end
end
