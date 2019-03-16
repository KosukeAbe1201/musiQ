class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.integer :question_num
      t.integer :user_id
      t.integer :correct

      t.timestamps
    end
  end
end
