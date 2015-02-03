class CreateUserToCategories < ActiveRecord::Migration
  def change
    create_table :user_to_categories do |t|
      t.integer :user_id
      t.integer :category_id

      t.timestamps
    end
  end
end
