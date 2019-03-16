class AddColumnToAnswer < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :name, :string
  end
end
