class Offender < ApplicationRecord
  belongs_to :prison

  validates_presence_of :convictedStatus, :firstName, :gender, :imprisonmentStatus, :lastName,
                        :mainOffence, :offenderNo, :receptionDate
end
