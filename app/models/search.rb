class Search < ApplicationRecord
  validates :post_id,{presence: true}
  validates :tag_id,{presence: true}

  def tags
    return Tag.where(id: self.id)
  end

end
