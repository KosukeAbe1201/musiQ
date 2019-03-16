class CreateKeywords < ActiveRecord::Migration[5.2]
  def change
    create_table :keywords do |t|
      t.string :keyword
      t.integer :user_id

      t.timestamps
    end
  end
end
