# frozen_string_literal: true

# ApplicationMailer is the base class for all mailers in the application.
# It provides shared functionality for sending emails.
#
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
