class User < ApplicationRecord
  validates :name, {presence: true, uniqueness: true}
  validates :email,{presence: true, uniqueness: true}
  validates :password, {presence: true}

  def posts
    return Post.where(user_id: self.id)
  end

  def like_posts
    posts = []
    likes = Like.where(user_id: self.id)

    likes.each do |like|
      post = Post.find_by(id: like.post_id)
      posts.push(post)
    end
   return posts
  end

  def see_posts
    posts = []
    sees = See.where(user_id: self.id)

    sees.each do |see|
      post = Post.find_by(id: see.post_id)
      posts.push(post)
    end
    return posts
  end

end
