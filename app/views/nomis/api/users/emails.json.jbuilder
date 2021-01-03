# frozen_string_literal: true
#
if @user.email.present?
  json.array! [@user.email]
else
  json.array! []
end

