# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { "MyString" }
    staffId { 1 }
    email { "me@example.com" }
  end
end