# frozen_string_literal: true

class User < ApplicationRecord
  validates :firstName, :lastName, :staffId, presence: true

  validates :position, inclusion: { in: %w[PO PRO], allow_nil: false }
end
