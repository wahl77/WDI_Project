class User < ActiveRecord::Base
  authenticates_with_sorcery!


  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :image, :first_name, :last_name

  has_one :image, as: :imageable, dependent: :destroy
  has_many :items, dependent: :destroy


  validates :email,
    presence: true,
    uniqueness: true,
    format:{with:EMAIL_REGEX}

  validates :password,
    #format:{with:PASSWORD_REGEX},
    presence:true, on: :create,
    confirmation:true


  def first_name=(value)
    write_attribute :first_name, value.capitalize
  end

  def last_name=(value)
    write_attribute :last_name, value.capitalize
  end
  

end
