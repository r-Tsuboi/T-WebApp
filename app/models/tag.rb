class Tag < ApplicationRecord
  validates :tag_name, {presence: true}

  def search_posts
    #投稿のデータを入れるための空の配列
    posts = []
    #タグのデータから検索データを取得
    searchs = Search.where(tag_id: self.id)

  　#複数の検索データを一つずつ処理
    searchs.each do |search|
      #検索データから投稿データを取得
      post = Post.find_by(id: search.post_id)
      #配列に入れていく
      posts.push(post)
    end
    #投稿の配列を返す
    return posts
  end



end
