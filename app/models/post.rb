class Post < ApplicationRecord
  validates :content, {length:{maximum: 500}}

def user
  return User.find_by(id: self.user_id)
end

end
