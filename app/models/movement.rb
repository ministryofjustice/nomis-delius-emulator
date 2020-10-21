# frozen_string_literal: true

class Movement < ApplicationRecord
  belongs_to :offender

  belongs_to :from_prison, class_name: "Prison", optional: true
  belongs_to :to_prison, class_name: "Prison", optional: true

  validates :typecode, inclusion: { in: %w[ADM TAP REL TRN], allow_nil: false }

  scope :by_type, ->(types) { where(typecode: types) }
end
