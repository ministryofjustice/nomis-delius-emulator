# frozen_string_literal: true

class Offender < ApplicationRecord
  belongs_to :prison
  has_many :movements, dependent: :destroy
  has_one :booking, dependent: :destroy
  belongs_to :keyworker, class_name: "User", optional: true

  validates :firstName, :imprisonmentStatus, :lastName,
            :mainOffence, :offenderNo, :receptionDate, :dateOfBirth, presence: true

  validates :offenderNo, uniqueness: true,
                         format: {
                           with: /\A[A-Z][0-9]{4}[A-Z]{2}\z/,
                           message: "must be of the form <letter><4 numbers><2 letters> (all uppercase)",
                         }

  after_create :create_inward_move, :create_active_booking
  before_update :create_transfer, if: -> { prison_id_changed? }

  scope :by_offender_no, ->(offender_ids) { where(offenderNo: offender_ids) }

  # simple way for active admin to show offender in a friendly way
  def name
    "#{firstName} #{lastName} (#{offenderNo})"
  end

  delegate :id, to: :booking, prefix: true

  def legal_status
    if recall_flag
      "RECALL"
    elsif imprisonmentStatus == "LIFE"
      "INDETERMINATE_SENTENCE"
    else
      "SENTENCED"
    end
  end

private

  def create_inward_move
    movements.create!(typecode: "ADM", directionCode: "IN", to_prison: prison, date: 4.days.ago)
  end

  def create_transfer
    movements.create!(typecode: "TRN", directionCode: "IN", from_prison_id: prison_id_was, to_prison: prison, date: Time.zone.today)
  end

  def create_active_booking
    release = if imprisonmentStatus == "LIFE"
                { tariffDate: 5.years.from_now }
              else
                { conditionalReleaseDate: 5.years.from_now, releaseDate: 5.years.from_now }
              end

    create_booking!({ sentenceStartDate: 1.week.ago }.merge(release))
  end
end
