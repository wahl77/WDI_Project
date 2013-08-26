class Comment < ActiveRecord::Base
  attr_accessible :content
  belongs_to :commentable, polymorphic: true

  belongs_to :sender, class_name: "User"
end
