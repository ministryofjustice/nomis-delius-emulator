# frozen_string_literal: true

# omit fields with nil values
json.ignore_nil!

json.prisonerNumber offender.offenderNo
json.extract! offender,
              :firstName,
              :lastName,
              :dateOfBirth,
              :cellLocation,
              :imprisonmentStatus,
              :restrictedPatient,
              :dischargedHospitalDescription,
              :supportingPrisonId

json.imprisonmentStatusDescription "Emulated #{offender.imprisonmentStatus} Sentence"
json.indeterminateSentence offender.imprisonmentStatus == "LIFE"
json.legalStatus offender.legal_status
json.recall offender.recall_flag

json.mostSeriousOffence offender.mainOffence
json.bookingId offender.booking&.id&.to_s
json.prisonId offender.prison.code

# Sentence dates from the offender's booking
if offender.booking.present?
  json.extract! offender.booking,
                :homeDetentionCurfewEligibilityDate,
                :paroleEligibilityDate,
                :releaseDate,
                :automaticReleaseDate,
                :conditionalReleaseDate,
                :tariffDate,
                :sentenceStartDate
end

# Hardcode offender to be 'in' prison
# This would need to change to emulate offender on temporary release (ROTL/SPL)
json.status "ACTIVE IN"
json.inOutStatus "IN"
json.lastMovementTypeCode "ADM"
json.lastMovementReasonCode "INT"
