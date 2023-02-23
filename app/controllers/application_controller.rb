# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authenticate_user!, except: %i[apiv1 do_stuff]
  rescue_from 'ActionController::ParameterMissing', with: :parameters_missing
  rescue_from 'ActiveRecord::RecordNotFound', with: :not_found
  include RequestResponses
  include Pundit::Authorization
  include SentryNotify
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def authenticate_user!
    return unauthenticated unless user_signed_in?

    current_user
  end

  private

  def unauthenticated
    error(:unauthorized)
  end
end
