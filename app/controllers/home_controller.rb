class HomeController < ApplicationController
  skip_before_action :authenticate_user! unless Rails.env.test?

  def index
  end
end
