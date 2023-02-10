# frozen_string_literal: true

module Api
  module V1
    module Sessions
      class AuthenticationController < Devise::SessionsController
        include ActionController::Flash
        skip_before_action :authenticate_user!
        respond_to :json

        private

        ##
        # If the resource is valid, render the resource as JSON with a status of
        # 200
        def respond_with(resource, _opts = {})
          return unauthenticated unless resource.valid?

          render json: I18n.t('response.devise.sessions.signed_in'), status: :ok
        end

        ##
        # It returns a JSON response unauthorized if something is missing or wrong
        def unauthenticated
          wrong_request(
            I18n.t('response.devise.failure.invalid'), :unauthorized
          )
        end

        ##
        # It returns a response with no content when destroy session
        def respond_to_on_destroy
          head :no_content
        end
      end
    end
  end
end