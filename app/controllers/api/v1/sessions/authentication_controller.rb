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
        # It returns an unauthenticated response if the resource is not valid,
        # otherwise it returns a signed in response
        #
        # Args:
        #   resource: The resource that was passed to the `sign_in` method.
        #   _opts: This is a hash of options that you can pass to the respond_with
        # method. Defaults to {}
        #
        # Returns:
        #   The response is being returned as a JSON object.
        def respond_with(resource, _opts = {})
          return unauthenticated unless resource.valid?

          render json: I18n.t('response.devise.sessions.signed_in'), status: :ok
        end

        ##
        # > If the user is not authenticated, return an error message
        def unauthenticated
          error(:unauthorized)
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
