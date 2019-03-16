class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :question
      t.integer :question_num
      t.string :answer1
      t.string :answer2
      t.string :answer3
      t.string :answer4
      t.integer :user_id

      t.timestamps
    end
  end
end
