class Prison < ApplicationRecord
  validates_presence_of :code, :name
end
