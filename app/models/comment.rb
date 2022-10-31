# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer
#  photo_id   :integer
#
class Comment < ApplicationRecord
  validates(:commenter, { :presence => true })

  belongs_to(:commenter, { :foreign_key => "author_id", :class_name => "User"})

end
