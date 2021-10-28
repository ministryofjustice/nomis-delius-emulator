# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Prisoner Offender Search API", type: :request do
  let(:base_url) { "/prison-search" }
  let(:response_json) { JSON.parse(response.body) }

  let(:leeds) { create(:prison, code: "LEI", name: "Leeds") }
  let(:pentonville) { create(:prison, code: "PVI", name: "Pentonville") }

  let!(:offender_1) do
    # in HMP Leeds with life sentence (indeterminate)
    create(:offender,
           imprisonmentStatus: "LIFE",
           prison: leeds,
           keyworker: build(:user))
  end

  let!(:offender_2) do
    # in HMP Leeds with determinate sentence
    create(:offender,
           prison: leeds)
  end

  let!(:offender_3) do
    # in HMP Pentonville with determinate sentence
    create(:offender,
           prison: pentonville)
  end

  describe "POST /prisoner-search/prisoner-numbers" do
    it "returns the requested offenders" do
      post "#{base_url}/prisoner-search/prisoner-numbers",
           params: { prisonerNumbers: [offender_1.offenderNo, offender_3.offenderNo] },
           as: :json

      expect(response).to be_successful
      expect(response_json).to eq [
        json_offender(offender_1),
        json_offender(offender_3),
      ]
    end
  end

  describe "GET /prisoner-search/prison/{prisonId}" do
    it "returns offenders in the requested prison" do
      get "#{base_url}/prisoner-search/prison/#{leeds.code}"

      expect(response).to be_successful
      expect(response_json.fetch("content")).to contain_exactly(json_offender(offender_1), json_offender(offender_2))
      expect(response_json.fetch("content")).not_to include(json_offender(offender_3))
    end
  end

private

  # Run the supplied object through a JSON encode/decode cycle
  # Useful when comparing non-string values against a JSON response
  # e.g. date objects will be serialized and re-hydrated as strings
  def json_object(object)
    JSON.parse(object.to_json)
  end

  def json_offender(offender)
    booking = offender.booking

    json_object({
      "prisonerNumber" => offender.offenderNo,
      "bookingId" => booking.id.to_s,
      "firstName" => offender.firstName,
      "lastName" => offender.lastName,
      "dateOfBirth" => offender.dateOfBirth,
      "status" => "ACTIVE IN",
      "lastMovementTypeCode" => "ADM",
      "lastMovementReasonCode" => "INT",
      "inOutStatus" => "IN",
      "prisonId" => offender.prison.code,
      "cellLocation" => offender.cellLocation,
      "legalStatus" => offender.legal_status,
      "imprisonmentStatus" => offender.imprisonmentStatus,
      "imprisonmentStatusDescription" => "Emulated #{offender.imprisonmentStatus} Sentence",
      "mostSeriousOffence" => "Robbery",
      "recall" => false,
      "indeterminateSentence" => (offender.imprisonmentStatus == "LIFE"),
      "homeDetentionCurfewEligibilityDate" => booking.homeDetentionCurfewEligibilityDate,
      "paroleEligibilityDate" => booking.paroleEligibilityDate,
      "releaseDate" => booking.releaseDate,
      "automaticReleaseDate" => booking.automaticReleaseDate,
      "conditionalReleaseDate" => booking.conditionalReleaseDate,
      "sentenceStartDate" => booking.sentenceStartDate,
      "tariffDate" => booking.tariffDate,
    }.compact)
  end
end
