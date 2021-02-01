# frozen_string_literal: true

json.extract! @user, :staffId
json.firstName @user.firstName.upcase
json.lastName @user.lastName.upcase
