class CreateTopChallenges < ActiveRecord::Migration[6.0]
  def change
    create_table :top_challenges do |t|
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.belongs_to :challenge
      t.timestamps
    end
  end
end
