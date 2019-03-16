class ChangeColumnOfAnswer < ActiveRecord::Migration[5.2]
  def change
    remove_column :answers, :correct
    add_column :answers, :correct, :integer, default: 0
  end
end
