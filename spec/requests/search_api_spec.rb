# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Prisoner Offender Search API", type: :request do
  let(:base_url) { "/prison-search" }

  let(:leeds) { create(:prison, code: "LEI", name: "Leeds") }
  let(:pentonville) { create(:prison, code: "PVI", name: "Pentonville") }

  let(:offender_1) { create(:offender, imprisonmentStatus: "LIFE", prison: leeds, keyworker: build(:user)) }
  let(:offender_2) { create(:offender, prison: leeds) }
  let(:offender_3) { create(:offender, prison: pentonville) }
  let!(:offenders) { [offender_1, offender_2, offender_3] }

  let(:response_json) { JSON.parse(response.body) }

  describe "POST /prisoner-search/prisoner-numbers" do
    let(:o1) do
      {
        "prisonerNumber" => offender_1.offenderNo,
        "recall" => false,
        "indeterminateSentence" => true,
        "imprisonmentStatus" => "LIFE",
        "imprisonmentStatusDescription" => "Emulated LIFE Sentence",
        "cellLocation" => offender_1.cellLocation,
      }
    end
    let(:o2) do
      {
        "prisonerNumber" => offender_2.offenderNo,
        "recall" => false,
        "indeterminateSentence" => false,
        "imprisonmentStatus" => "SENT03",
        "imprisonmentStatusDescription" => "Emulated SENT03 Sentence",
        "cellLocation" => offender_2.cellLocation,
      }
    end
    let(:o3) do
      {
        "prisonerNumber" => offender_3.offenderNo,
        "recall" => false,
        "indeterminateSentence" => false,
        "imprisonmentStatus" => "SENT03",
        "imprisonmentStatusDescription" => "Emulated SENT03 Sentence",
        "cellLocation" => offender_3.cellLocation,
      }
    end

    it "returns the offenders" do
      post "#{base_url}/prisoner-search/prisoner-numbers",
           params: { prisonerNumbers: offenders.map(&:offenderNo) },
           as: :json

      expect(response).to be_successful
      expect(response_json).to eq json_object([o1, o2, o3])
    end
  end

private

  # Run the supplied object through a JSON encode/decode cycle
  # Useful when comparing non-string values against a JSON response
  # e.g. date objects will be serialized and re-hydrated as strings
  def json_object(object)
    JSON.parse(object.to_json)
  end
end
