class Prison < ApplicationRecord
  has_many :offenders

  validates_presence_of :code, :name
end
