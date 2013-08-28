class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :image, :first_name, :last_name


  has_one :image, as: :imageable, dependent: :destroy # Profile picture
  has_many :items, dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :locations, through: :addresses

  has_many :comments, through: :items

  validates :email,
    presence: true,
    uniqueness: true,
    format:{with:EMAIL_REGEX}

  validates :password,
    presence:true, on: :create,
    confirmation:true

  validates :password, 
    format:{with:PASSWORD_REGEX, message: "Password must be at least 8 characters long"},
    if: lambda{ Rails.env.production? }

 accepts_nested_attributes_for :image
 attr_accessible :image_attributes

  def first_name=(value)
    write_attribute :first_name, value.capitalize
  end

  def last_name=(value)
    write_attribute :last_name, value.capitalize
  end

  def current_location
    return Location.where("locatable_type = ? AND locatable_id = ?", self.class.to_s, self.id).last
  end

  def current_location=(value)
    if self.current_location.nil?
      location = Location.new(latitude: value.latitude, longitude: value.longitude)
      location.locatable_type = self.class.to_s
      location.locatable_id = self.id
      location.save
    else
      self.current_location.update_attributes(:latitude =>  value.latitude, :longitude => value.longitude)
    end
    save!
  end

  def locations
    locations = []
    locations << Location.where("locatable_type = ?", self.class.to_s).first 
    self.addresses.each do |address|
      locations << address.location
    end
    return locations
  end

  def time_since_last_update
    return Time.now - current_location.updated_at
  end

  def last_location_is_good?
    return time_since_last_update < 3600 ? true : false
  end

end
