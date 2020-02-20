class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.belongs_to :challenge
      t.belongs_to :user
      t.timestamps
    end
  end
end
