# frozen_string_literal: true

require "rails_helper"

RSpec.describe Offender, type: :model do
  it "creates ADM movement when first created" do
    expect { create(:offender) }.to change(Movement, :count).by(1)
    expect(described_class.last.movements.first.typecode).to eq("ADM")
  end

  context "when prison changed" do
    before do
      create(:offender)
      create(:prison)
    end

    it "creates a transfer" do
      expect { described_class.last.update(prison: Prison.last) }.to change(Movement, :count).by(1)

      expect(described_class.last.movements.last.attributes.symbolize_keys.except(:id, :created_at, :updated_at, :offender_id)).
          to eq(typecode: "TRN", from_prison_id: Prison.first.id, to_prison_id: Prison.last.id)
    end
  end
end
