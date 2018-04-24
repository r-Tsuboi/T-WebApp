class Post < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :user_id, :integer
    add_column :posts, :post_image, :integer
  end
end
