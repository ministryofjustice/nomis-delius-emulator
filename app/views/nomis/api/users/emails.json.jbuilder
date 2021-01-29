# frozen_string_literal: true

if @user.email.present?
  json.array! @user.email.split(",")
else
  json.array! []
end
