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
  form do |f|
    f.input :prison_id
    f.input :offenderNo
    f.input :categoryCode
    f.input :gender
    f.input :mainOffence
    f.input :receptionDate
    f.input :firstName
    f.input :lastName
    f.input :imprisonmentStatus
    f.input :dateOfBirth, as: :datepicker,
            datepicker_options: {
        min_date: Time.zone.today - 80.years,
        max_date: Time.zone.today - 18.years,
    }
    f.submit
  end
end
