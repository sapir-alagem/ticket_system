class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :subject
      t.text :content
      t.integer :status
      t.integer :user_id

      t.timestamps
    end
  end
end
