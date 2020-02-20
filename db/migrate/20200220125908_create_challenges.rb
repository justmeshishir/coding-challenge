class CreateChallenges < ActiveRecord::Migration[6.0]
  def change
    create_table :challenges do |t|
      t.string :name, null: false
      t.text :description, null: false, default: ''
      t.text :question, null: false, default: ''
      t.integer :difficulty_level, default: 0
      t.belongs_to :user

      t.timestamps
    end
  end
end
