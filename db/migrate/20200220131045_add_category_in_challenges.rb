class AddCategoryInChallenges < ActiveRecord::Migration[6.0]
  def change
    add_column :challenges, :category_id, :integer
    add_foreign_key :challenges, :categories
  end
end
