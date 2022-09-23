class ApplicationController < ActionController::Base
  before_action :basic_auth

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["furima38450_BASIC_AUTH_USER"] && password == ENV["furima38450_BASIC_AUTH_PASSWORD"]
    end
  end

end
