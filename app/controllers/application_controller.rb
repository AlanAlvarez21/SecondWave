# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  include Pagy::Backend

  around_action :switch_locale
  before_action :set_current_user
  before_action :protect_pages

  # En cada petición se llama esté método para cambiar idioma de app para esa petición en concreto
  def switch_locale(&action)
    I18n.with_locale(locale_from_header, &action)
  end

  private

  # Lee cabezera que se manda en la petición
  def locale_from_header
    request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
  end

  # Setea el current user en función de la session[user_id]
  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def protect_pages
    redirect_to new_session_path, alert: t('common.not_logged_in') unless Current.user
  end
end
