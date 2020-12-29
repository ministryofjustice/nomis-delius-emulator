# frozen_string_literal: true

class Offender < ApplicationRecord
  belongs_to :prison
  has_many :movements
  has_one :booking
  belongs_to :keyworker, class_name: "User", optional: true

  validates_presence_of :firstName, :gender, :imprisonmentStatus, :lastName,
                        :mainOffence, :offenderNo, :receptionDate, :dateOfBirth

  after_create :create_inward_move
  before_update :create_transfer, if: -> { prison_id_changed? }

  # simple way for active admin to show offender in a friendly way
  def name
    "#{firstName} #{lastName} (#{offenderNo})"
  end

private

  def create_inward_move
    movements.create!(typecode: "ADM", to_prison: prison)
  end

  def create_transfer
    movements.create!(typecode: "TRN", from_prison_id: prison_id_was, to_prison: prison)
  end
end
