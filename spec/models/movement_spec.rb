require "rails_helper"

RSpec.describe Movement, type: :model do
  describe "validations" do
    it { should validate_inclusion_of(:typecode).in? %w[ADM TAP REL TRN] }
  end
end
