class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  # Devise authentication
  before_action :authenticate_user! unless Rails.env.test?

  # Pundit authorization
  unless Rails.env.test?
    include Pundit::Authorization
    after_action :verify_authorized, except: :index
    after_action :verify_policy_scoped, only: :index
  end
end
