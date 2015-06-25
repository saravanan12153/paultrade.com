class AddSoldToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :sold, :boolean, default: false
  end
end
