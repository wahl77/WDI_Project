class Image < ActiveRecord::Base
  attr_accessible :url
  belongs_to :imageable, polymorphic:true
  mount_uploader :url, ImageUploader
end
