class AddCategoryInChallenges < ActiveRecord::Migration[6.0]
  def change
    add_column :challenges, :category_name, :string
  end
end
