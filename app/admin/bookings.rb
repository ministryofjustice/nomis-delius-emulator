# frozen_string_literal: true

ActiveAdmin.register Booking do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :offender_id, :homeDetentionCurfewEligibilityDate, :paroleEligibilityDate, :releaseDate, :automaticReleaseDate, :conditionalReleaseDate, :sentenceStartDate, :tariffDate
  #
  # or
  #
  # permit_params do
  #   permitted = [:offender_id, :home_detention_curfew_eligibility_date, :parole_eligibility_date, :release_date, :automatic_release_date, :conditional_release_date, :sentence_start_date, :tariff_date]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form do |f|
    inputs do
      # We only want 1 booking per offender, so only list those w/o bookings
      input :offender, collection: Offender.without_bookings + [f.object.offender].compact
      input :homeDetentionCurfewEligibilityDate, as: :datepicker
      input :paroleEligibilityDate, as: :datepicker
      input :releaseDate, as: :datepicker
      input :automaticReleaseDate, as: :datepicker
      input :conditionalReleaseDate, as: :datepicker
      input :sentenceStartDate, as: :datepicker
      input :tariffDate, as: :datepicker
    end
    actions
  end
end
