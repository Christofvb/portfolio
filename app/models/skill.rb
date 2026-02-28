class Skill < ApplicationRecord
  SKILL_TYPES = {
    language: 0,
    framework: 1,
    tool: 2,
    other: 3
  }.freeze

  validates :name, presence: true
  validates :skill_type, inclusion: { in: SKILL_TYPES.values }

  # Optionnel : des méthodes d’aide pour afficher le label
  def skill_type_label
    SKILL_TYPES.key(skill_type).to_s.humanize
  end
end
