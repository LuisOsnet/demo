# frozen_string_literal: true

# Handle error messages
module RequestResponses
  extend ActiveSupport::Concern

  def wrong_request(message, http_status_code, resource = nil)
    opts = { status: http_status_code }
    opts[:message] ||= message
    opts[:errors] ||= resource
    render status: opts[:status], json: {
      message: opts[:message],
      errors: opts[:errors]&.uniq || {}
    }
  end
end