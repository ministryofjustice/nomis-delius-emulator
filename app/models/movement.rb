class Movement < ApplicationRecord
  belongs_to :from_prison, class_name: Prison.name, optional: true
  belongs_to :to_prison, class_name: Prison.name, optional: true

  validates :typecode, inclusion: { in: %w[ADM TAP REL TRN], allow_nil: false }
end
