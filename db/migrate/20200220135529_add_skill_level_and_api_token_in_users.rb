class AddSkillLevelAndApiTokenInUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :skill_level, :integer, default: 0
    add_column :users, :api_token, :string
  end
end
