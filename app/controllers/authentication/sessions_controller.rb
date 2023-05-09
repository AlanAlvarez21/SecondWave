# frozen_string_literal: true

# Sessions Controller
module Authentication
    # Users Controller
    class SessionsController < ApplicationController

        def new
        end

        def create
          @user = User.find_by('email = :login OR username = :login', { login: params[:login] })

          if @user&.authenticate(params[:password])
            redirect_to products_path, alert: t('.created')
          else
            redirect_to new_session_path, alert: t('.failed')
          end
        end
    end
end
