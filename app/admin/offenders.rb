ActiveAdmin.register Offender do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :prison_id, :categoryCode, :gender, :mainOffence, :receptionDate, :firstName, :lastName, :offenderNo, :convictedStatus, :imprisonmentStatus, :dateOfBirth
  #
  # or
  #
  # permit_params do
  #   permitted = [:prison_id, :gender, :mainOffence, :receptionDate, :firstName, :lastName, :offenderNo, :convictedStatus, :imprisonmentStatus, :dateOfBirth]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
