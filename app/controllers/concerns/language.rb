# frozen_string_literal: true

module Language
  extend ActiveSupport::Concern

  included do
    around_action :switch_locale

    private

    # En cada petición se llama esté método para cambiar idioma de app para esa petición en concreto
    def switch_locale(&action)
      I18n.with_locale(locale_from_header, &action)
    end

    # Lee cabezera que se manda en la petición
    def locale_from_header
      request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
    end
  end
end
