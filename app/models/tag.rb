class Tag < ApplicationRecord

  def search_posts
    posts = []
    searchs = Search.where(tag_id: self.id)

    searchs.each do |search|
      post = Post.find_by(id: search.post_id)
      posts.push(post)
    end
    return posts
  end

end
