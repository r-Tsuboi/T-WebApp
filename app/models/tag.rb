class Tag < ApplicationRecord

  def searchs
    return Search.where(tag_id: self.id)
  end

end
