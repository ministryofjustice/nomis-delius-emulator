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

      expect(described_class.last.movements.last.attributes.symbolize_keys.except(:id, :date, :created_at, :updated_at, :offender_id))
          .to eq(typecode: "TRN", directionCode: "IN", from_prison_id: Prison.first.id, to_prison_id: Prison.last.id)
    end
  end

  describe "#legal_status" do
    subject { offender.legal_status }

    context "when offender has a LIFE sentence" do
      let(:offender) { build(:offender, imprisonmentStatus: "LIFE", recall_flag: false) }

      it { is_expected.to eq "INDETERMINATE_SENTENCE" }
    end

    context "when offender has a determinate sentence" do
      let(:offender) { build(:offender, imprisonmentStatus: "SENT03", recall_flag: false) }

      it { is_expected.to eq "SENTENCED" }
    end

    context "when the offender is a recall" do
      let(:offender) { build(:offender, imprisonmentStatus: "SENT03", recall_flag: true) }

      it { is_expected.to eq "RECALL" }
    end
  end
end
