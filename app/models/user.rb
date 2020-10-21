# frozen_string_literal: true

class User < ApplicationRecord
  validates_presence_of :firstName, :lastName, :staffId

  validates_inclusion_of :position, in: %w[PO PRO], allow_nil: false
end
