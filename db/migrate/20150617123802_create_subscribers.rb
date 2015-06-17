class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps null: false
    end
    add_index :subscribers, :user_id
    add_index :subscribers, :post_id
  end
end
