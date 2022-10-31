# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fan_id     :integer
#  photo_id   :integer
#
class Like < ApplicationRecord
  validates(:fan, { :presence => true })
  validates(:photo, { 
    :presence => true,
    :uniqueness => { :scope => [:fan_id] }
  })

  belongs_to(:fan, { :foreign_key => "fan_id", :class_name => "User"})

  belongs_to(:photo, { :foreign_key => "photo_id", :class_name => "Photo" })

end
