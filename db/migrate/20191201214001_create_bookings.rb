# frozen_string_literal: true

class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.references :offender, null: false
      t.date :homeDetentionCurfewEligibilityDate
      t.date :paroleEligibilityDate
      t.date :releaseDate
      t.date :automaticReleaseDate
      t.date :conditionalReleaseDate
      t.date :sentenceStartDate
      t.date :tariffDate

      t.timestamps
    end
  end
end
