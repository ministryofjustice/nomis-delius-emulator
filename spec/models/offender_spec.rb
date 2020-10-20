require "rails_helper"

RSpec.describe Offender, type: :model do
  it "creates ADM movement when first created" do
    expect { create(:offender) }.to change(Movement, :count).by(1)
    expect(Movement.last.typecode).to eq("ADM")
  end

  context "when prison changed" do
    before do
      create(:offender)
      create(:prison)
    end

    it "creates a transfer" do
      expect { described_class.last.update(prison: Prison.last) }.to change(Movement, :count).by(1)

      expect(Movement.last.typecode).to eq("TRN")
      expect(Movement.last.from_prison).to eq(Prison.first)
      expect(Movement.last.to_prison).to eq(Prison.last)
    end
  end
end
