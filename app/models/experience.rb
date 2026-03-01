class Experience < ApplicationRecord
  include Mobility

  translates :job_title, type: :string
  translates :missions,  type: :text
  translates :tools,     type: :text

  has_many :projects, dependent: :destroy
  accepts_nested_attributes_for :projects, allow_destroy: true
end
