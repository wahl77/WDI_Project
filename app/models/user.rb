class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :items
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :image

  has_one :image, as: :imageable


  validates :email,
    presence: true,
    uniqueness: true,
    format:{with:EMAIL_REGEX}

  validates :password,
    presence:true, on: :create,
    confirmation:true
#    format:{with:SOME_REGEX}
  

end
