class CreateCategoryToQuestions < ActiveRecord::Migration
  def change
    create_table :category_to_questions do |t|
      t.references :category
      t.references :question

      t.timestamps
    end
  end
end
