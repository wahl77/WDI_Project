class Address < ActiveRecord::Base
  before_save :create_location
  attr_accessible :city, :number_and_street, :state, :zip_code, :name

  belongs_to :addressable, polymorphic:true
  has_one :location, as: :locatable, dependent: :destroy
  
  validates :city,
    presence:true

  validates :number_and_street,
    presence:true,
    length:{maximum: 250}

  validates :city,
    presence:true,
    length:{maximum: 50}

  validates :state,
    presence:true,
    length:{maximum: 50}

  validates :zip_code,
    format:{with: /(0-9)*/}

  def to_string
    return "#{number_and_street}, #{city}, #{state}"
  end

  def create_location
    json = Gmaps4rails.geocode(to_string)
    self.location = Location.create(latitude: json[0][:lat], longitude: json[0][:lng])

  end
end
