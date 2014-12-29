class CreateQuestionAnswers < ActiveRecord::Migration
  def change
    create_table :question_answers do |t|
      t.references :question, index: true
      t.references :answer, index: true

      t.timestamps
    end
  end
end
