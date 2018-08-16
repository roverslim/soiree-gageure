# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_locale

  prepend_view_path Rails.root.join('components', 'registration_process', 'app', 'views')
  prepend_view_path Rails.root.join('components', 'draw_bookkeeping', 'app', 'views')

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
