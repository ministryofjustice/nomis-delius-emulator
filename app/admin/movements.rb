# frozen_string_literal: true

ActiveAdmin.register Movement do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :offender_id, :from_prison_id, :to_prison_id, :typecode, :directionCode, :date
  #
  # or
  #
  # permit_params do
  #   permitted = [:offender_id, :from_prison_id, :to_prison_id, :typecode]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form do |_f|
    inputs do
      input :offender
      input :from_prison
      input :to_prison
      input :typecode
      input :directionCode
      input :date, as: :datepicker
      actions
    end
  end
end
