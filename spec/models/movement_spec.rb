# frozen_string_literal: true

require "rails_helper"

RSpec.describe Movement, type: :model do
  describe "validations" do
    it { is_expected.to validate_inclusion_of(:typecode).in_array(%w[ADM TAP REL TRN]) }
  end
end
