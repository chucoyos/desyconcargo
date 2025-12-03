class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  # Devise authentication
  before_action :authenticate_user! unless Rails.env.test?

  # Pundit authorization
  include Pundit::Authorization
  after_action :verify_authorized, if: -> { action_name != "index" && !params[:controller]&.start_with?("devise/") } unless Rails.env.test?
  after_action :verify_policy_scoped, if: -> { action_name == "index" && !params[:controller]&.start_with?("devise/") && params[:controller] != "home" } unless Rails.env.test?
end
