# frozen_string_literal: true

require "rails_helper"

RSpec.describe Offender, type: :model do
  it "creates ADM movement when first created" do
    expect { create(:offender) }.to change(Movement, :count).by(1)
    expect(described_class.last.movements.first.typecode).to eq("ADM")
  end

  describe "#without_bookings" do
    before do
      create(:offender, booking: build(:booking))
    end


    let!(:o1) { create(:offender) }
    let!(:o2) { create(:offender) }

    it "pulls back non-bookings" do
      expect(described_class.without_bookings).to match_array [o1, o2]
    end
  end

  describe "#name" do
    let(:offender) { create(:offender) }

    it "has a friendly name for ActiveAdmin to use" do
      expect(offender.name).to eq("Fred Bloggs (#{offender.offenderNo})")
    end
  end

  context "when prison changed" do
    before do
      create(:offender)
      create(:prison)
    end

    it "creates a transfer" do
      expect { described_class.last.update(prison: Prison.last) }.to change(Movement, :count).by(1)

      expect(described_class.last.movements.last.attributes.symbolize_keys.except(:id, :date, :created_at, :updated_at, :offender_id)).
          to eq(typecode: "TRN", directionCode: "IN", from_prison_id: Prison.first.id, to_prison_id: Prison.last.id)
    end
  end
end
