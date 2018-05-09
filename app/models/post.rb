class Post < ApplicationRecord
  validates :title, {presence: true}
  validates :content, {length:{maximum: 500}, presence: true}

def user
  return User.find_by(id: self.user_id)
end

def search_tags
  tags = []
  searchs = Search.where(post_id: self.id)

  searchs.each do |search|
    tag = Tag.find_by(id: search.tag_id)
    tags.push(tag)
  end
  return tags

end

end
