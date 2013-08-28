class Comment < ActiveRecord::Base
  attr_accessible :content, :public
  belongs_to :commentable, polymorphic: true

  belongs_to :sender, class_name: "User"


  def public?
    return self.public
  end
end
