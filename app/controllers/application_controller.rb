# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  include Authentication
  include Authorization
  include Language
  include Pagy::Backend
end
