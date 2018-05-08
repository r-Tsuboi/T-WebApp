class Search < ApplicationRecord

  def tags
    return Tag.where(id: self.id)
  end

end
