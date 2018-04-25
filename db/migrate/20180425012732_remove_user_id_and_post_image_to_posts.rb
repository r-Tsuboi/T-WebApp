class RemoveUserIdAndPostImageToPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :user_id, :integer
    remove_column :posts, :post_image, :integer
  end
end
