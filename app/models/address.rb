class Address < ActiveRecord::Base
  attr_accessible :city, :number_and_street, :state, :zip_code, :name

  belongs_to :addressable, polymorphic:true
  has_one :location, as: :locatable, dependent: :destroy
  
  validates :city,
    presence:true

  validates :number_and_stree,
    presence:true,
    maximum: 250

  validates :city,
    presence:true,
    maximum: 50

  validates :state,
    presence:true,
    maximum: 50

  validates :zip_code,
    format:{with: /(0-9)*/}


end
