class AddManagerToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :manager, :boolean
  end
end
