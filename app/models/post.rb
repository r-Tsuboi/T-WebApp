class Post < ApplicationRecord
  validates :title, {presence: true}
  validates :content, {length:{maximum: 500}, presence: true}

def user
  #取得した投稿データのユーザIDからユーザデータを取得し、返す
  return User.find_by(id: self.user_id)
end


def search_tags
  #タグ情報を入れるための空の配列
  tags = []
  #取得した投稿データから検索用のデータを取得
  searchs = Search.where(post_id: self.id)

  #複数の検索データを一つずつ処理する
  searchs.each do |search|
    #検索データからタグデータを取得
    tag = Tag.find_by(id: search.tag_id)
    #取得したタグのデータを空の配列に入れていく
    tags.push(tag)
  end
  #タグの配列を返す
  return tags
end

end
