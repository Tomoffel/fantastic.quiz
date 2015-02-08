class CreateQuizRounds < ActiveRecord::Migration
  def change
    create_table :quiz_rounds do |t|
      t.references :category, index: true
      t.references :user, index: true
      t.references :question, index: true
      t.boolean :correct

      t.timestamps
    end
  end
end
