class User < ApplicationRecord
  validates :name, {presence: true, uniqueness: true}
  validates :email,{presence: true, uniqueness: true}
  validates :password, {presence: true}

  def posts
    #ユーザIDから投稿のデータを取得し返す
    return Post.where(user_id: self.id)
  end

  def like_posts
    #投稿データを入れるための空の配列
    posts = []
    #ユーザIDからいいねのデータを取得
    likes = Like.where(user_id: self.id)

    #取得した複数のいいねのデータを一つずつ処理
    likes.each do |like|
      #いいねのデータから投稿のデータを取得
      post = Post.find_by(id: like.post_id)
      #投稿データを配列に入れる
      posts.push(post)
    end
    #投稿の配列を返す
    return posts
  end

  def see_posts
    #投稿データを入れるための空の配列
    posts = []
    #ユーザIDからわかるのデータを取得
    sees = See.where(user_id: self.id)

    #取得した複数のわかるのデータを一つずつ処理
    sees.each do |see|
      #わかるデータかた投稿データを取得
      post = Post.find_by(id: see.post_id)
      #投稿データを配列に入れる
      posts.push(post)
    end
    #投稿の配列を返す
    return posts
  end

end
