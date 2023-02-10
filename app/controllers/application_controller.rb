class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authenticate_user!, except: %i[apiv1 do_stuff]
  rescue_from 'ActionController::ParameterMissing', with: :parameters_missing
  rescue_from 'ActiveRecord::RecordNotFound', with: :not_found
  include RequestResponses

  def authenticate_user!
    return unauthenticated unless user_signed_in?

    current_user
  end

  private

  def unauthenticated
    render json: I18n.t('response.devise.failure.invalid'),
    status: :unauthorized
  end
end
