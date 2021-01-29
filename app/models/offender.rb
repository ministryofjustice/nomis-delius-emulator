# frozen_string_literal: true

class Offender < ApplicationRecord
  BOOKING_ID_OFFSET = 1_153_750
  belongs_to :prison
  has_many :movements
  has_one :booking
  belongs_to :keyworker, class_name: "User", optional: true

  validates_presence_of :firstName, :gender, :imprisonmentStatus, :lastName,
                        :mainOffence, :offenderNo, :receptionDate, :dateOfBirth

  after_create :create_inward_move
  before_update :create_transfer, if: -> { prison_id_changed? }

  scope :by_offender_no, ->(offender_ids) { where(offenderNo: offender_ids) }

  # simple way for active admin to show offender in a friendly way
  def name
    "#{firstName} #{lastName} (#{offenderNo})"
  end

  def booking_id
    booking.id + BOOKING_ID_OFFSET
  end

private

  def create_inward_move
    movements.create!(typecode: "ADM", directionCode: "IN", to_prison: prison, date: Time.zone.today)
  end

  def create_transfer
    movements.create!(typecode: "TRN", directionCode: "IN", from_prison_id: prison_id_was, to_prison: prison, date: Time.zone.today)
  end
end
