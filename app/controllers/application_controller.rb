# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :authenticate_user!

  prepend_view_path Rails.root.join('components', 'registration_process', 'app', 'views')
  prepend_view_path Rails.root.join('components', 'draw_bookkeeping', 'app', 'views')

  def self.default_url_options(options={})
    options.merge({ locale: I18n.locale })
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
