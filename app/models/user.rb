# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  comments_count  :integer
#  email           :string
#  likes_count     :integer
#  password_digest :string
#  private         :boolean
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password
  
  has_many(:comments, {
    :foreign_key => "author_id"
  })

  has_many(:own_photos, {
    :class_name => "Photo",
    :foreign_key => "owner_id"
  })
  
def likes
  my_id = self.id

  matching_likes = Like.where({ :fan_id => my_id })

  return matching_likes
end

def liked_photos
  my_likes = self.likes
      
  array_of_photo_ids = Array.new

  my_likes.each do |a_like|
    array_of_photo_ids.push(a_like.photo_id)
  end

  matching_photos = Photo.where({ :id => array_of_photo_ids })

  return matching_photos
end

end
