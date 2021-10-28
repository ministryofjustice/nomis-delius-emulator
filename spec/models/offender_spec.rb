# frozen_string_literal: true

require "rails_helper"

RSpec.describe Offender, type: :model do
  describe "when creating a new offender" do
    it "creates ADM movement" do
      expect { create(:offender) }.to change(Movement, :count).by(1)
      expect(described_class.last.movements.first.typecode).to eq("ADM")
    end

    context "with a LIFE sentence" do
      it "creates a booking" do
        expect { create(:offender, imprisonmentStatus: "LIFE") }.to change(Booking, :count).by(1)
        expect(described_class.last.booking.sentenceStartDate).to be_past
        expect(described_class.last.booking.tariffDate).to be_future
      end
    end

    context "with a determinate sentence" do
      it "creates a booking" do
        expect { create(:offender, imprisonmentStatus: "SENT03") }.to change(Booking, :count).by(1)
        expect(described_class.last.booking.sentenceStartDate).to be_past
        expect(described_class.last.booking.conditionalReleaseDate).to be_future
      end
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

  describe "#offenderNo" do
    # NOMIS offender IDs must be of the form <letter><4 numbers><2 letters>
    let(:valid_ids) { %w[A0000AA Z5432HD A4567CD] }

    let(:invalid_ids) do
      [
        "A 1234 AA", # no spaces allowed
        "E123456", # this is a nDelius CRN, not a NOMIS ID
        "A0000aA", # must be all uppercase
        "", # cannot be empty
        nil, # cannot be nil
        "1234567",
        "ABCDEFG",
      ]
    end

    it "requires a valid NOMIS offender ID" do
      valid_ids.each do |id|
        expect(build(:offender, offenderNo: id)).to be_valid
      end

      invalid_ids.each do |id|
        expect(build(:offender, offenderNo: id)).not_to be_valid
      end
    end
  end
end
