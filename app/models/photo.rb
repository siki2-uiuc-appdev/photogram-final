# == Schema Information
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  caption        :text
#  comments_count :integer
#  image          :string
#  likes_count    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#
class Photo < ApplicationRecord
  validates(:poster, { :presence => true })
  
  mount_uploader :image, ImageUploader

  belongs_to(:poster, { :foreign_key => "owner_id", :class_name => "User"})

  has_many :comments

  has_many :likes

  has_many(:fans, { :through => :likes, :source => :fan})

  has_many(:fan_list, -> {select :username}, { :through => :likes, :source => :fan })


end
