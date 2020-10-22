# frozen_string_literal: true

ActiveAdmin.register Offender do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :prison_id, :categoryCode, :gender, :mainOffence, :receptionDate, :firstName, :lastName, :offenderNo,
                :imprisonmentStatus, :dateOfBirth
  #
  # or
  #
  # permit_params do
  #   permitted = [:prison_id, :gender, :mainOffence, :receptionDate, :firstName, :lastName, :offenderNo, :convictedStatus, :imprisonmentStatus, :dateOfBirth]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form do |_f|
    inputs do
      input :prison
      input :offenderNo
      input :categoryCode
      input :gender
      input :mainOffence
      input :receptionDate
      input :firstName
      input :lastName
      input :imprisonmentStatus
      input :dateOfBirth, as: :datepicker,
              datepicker_options: {
                  min_date: Time.zone.today - 80.years,
                  max_date: Time.zone.today - 18.years,
              }
      actions
    end
  end
end
