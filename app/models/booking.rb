# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :offender

  validates_presence_of :sentenceStartDate
end
