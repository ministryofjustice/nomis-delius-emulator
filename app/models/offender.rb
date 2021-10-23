# frozen_string_literal: true

class Offender < ApplicationRecord
  belongs_to :prison
  has_many :movements
  has_one :booking
  belongs_to :keyworker, class_name: "User", optional: true

  validates :firstName, :imprisonmentStatus, :lastName,
            :mainOffence, :offenderNo, :receptionDate, :dateOfBirth, presence: true

  validates :offenderNo, uniqueness: true

  after_create :create_inward_move
  before_update :create_transfer, if: -> { prison_id_changed? }

  scope :by_offender_no, ->(offender_ids) { where(offenderNo: offender_ids) }

  scope :without_bookings, lambda {
    left_joins(:booking).where("bookings.offender_id is null")
  }

  # simple way for active admin to show offender in a friendly way
  def name
    "#{firstName} #{lastName} (#{offenderNo})"
  end

  delegate :id, to: :booking, prefix: true

private

  def create_inward_move
    movements.create!(typecode: "ADM", directionCode: "IN", to_prison: prison, date: Time.zone.today)
  end

  def create_transfer
    movements.create!(typecode: "TRN", directionCode: "IN", from_prison_id: prison_id_was, to_prison: prison, date: Time.zone.today)
  end
end
