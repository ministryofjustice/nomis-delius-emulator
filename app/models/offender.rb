class Offender < ApplicationRecord
  belongs_to :prison
  has_many :movements

  validates_presence_of :convictedStatus, :firstName, :gender, :imprisonmentStatus, :lastName,
                        :mainOffence, :offenderNo, :receptionDate

  after_create :create_inward_move
  before_update :create_transfer, if: -> { prison_id_changed? }

  private

  def create_inward_move
    movements.create!(typecode: 'ADM', to_prison: prison)
  end

  def create_transfer
    movements.create!(typecode: 'TRN', from_prison_id: prison_id_was, to_prison: prison)
  end
end
