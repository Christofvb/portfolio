class Project < ApplicationRecord
  include Mobility

  translates :name,        type: :string
  translates :description, type: :text

  belongs_to :experience
end
