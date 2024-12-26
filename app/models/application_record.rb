# frozen_string_literal: true

# ApplicationRecord is the base class for all models in the application.
# It provides shared functionality for interacting with the database.
#
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
