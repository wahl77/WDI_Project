class ImageUploader < FileUploader
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end


  def store_dir
    "uploads/images/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
