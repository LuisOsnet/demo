# frozen_string_literal: true

module RequestResponses
  extend ActiveSupport::Concern

  ##
  # It renders a JSON response with a status code and a message
  #
  # Args:
  #   http_status_code: The HTTP status code to return.
  #   resource: The resource that is being requested. Defaults to nil
  #   message: The message to be displayed to the user. Defaults to nil
  def error(http_status_code, resource = nil, message = nil)
    opts = { status: http_status_code }
    opts[:message] ||= message || I18n.t("response.errors.messages.#{http_status_code}")
    opts[:errors] ||= resource
    render status: http_status_code, json: {
      error: {
        code: Rack::Utils.status_code(http_status_code),
        status: http_status_code,
        resource: controller_name,
        message: opts[:message],
        details: opts[:errors] || {}
      }
    }
  end
end
