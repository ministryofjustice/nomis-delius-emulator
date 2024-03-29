# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :offender

  validates :sentenceStartDate, presence: true
end
