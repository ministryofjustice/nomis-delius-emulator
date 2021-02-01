# frozen_string_literal: true

json.extract! @user, :staffId, :username, :firstName, :lastName
json.extract! @caseload, :activeCaseLoadId
