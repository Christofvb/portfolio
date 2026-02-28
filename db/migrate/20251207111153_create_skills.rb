class CreateSkills < ActiveRecord::Migration[8.0]
  def change
    create_table :skills do |t|
      t.timestamps
      t.string :name, null: false
      t.string :image_path
      t.integer :skill_type, null: false, default: 0
    end
  end
end
