# frozen_string_literal: true

class Prison < ApplicationRecord
  has_many :offenders, dependent: :destroy

  validates :code, :name, presence: true
end
