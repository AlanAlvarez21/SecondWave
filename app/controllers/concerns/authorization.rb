# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  included do
    class NotAuthorizedError < StandardError; end
    rescue_from NotAuthorizedError do
      redirect_to products_path, alert: t('common.not_authorized')
    end

    private

    def authorize!(record = nil)
      # classify: convierte un string a nombre de clase
      # send: se le pasa un string o simbolo con el nombre de la acción
      # Ejemplo de String dínamico: is_allowed = ProductPolicy.new.edit
      is_allowed = "#{controller_name.singularize}Policy".classify.constantize.new(record).send(action_name)
      raise NotAuthorizedError unless is_allowed
    end
  end
end
