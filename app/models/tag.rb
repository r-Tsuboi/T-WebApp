class Tag < ApplicationRecord

  def posts
    return Post.where(user_id: self.id)
  end

end
