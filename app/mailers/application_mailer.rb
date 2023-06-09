# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@vendelo.com'
  layout 'mailer'
end
