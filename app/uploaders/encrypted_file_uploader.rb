class EncryptedFileUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # make original filename accessible from model
  def original_file
    original_filename
  end

  def filename
    if original_filename
      @name ||= Gibberish::MD5(File.dirname(current_path))
      "#{@name}.#{file.extension.downcase}"
    end
  end


  process :encrypt_file

  def encrypt_file
    CarrierWave::EncryptFile::Uploader.encrypt_file(self.file.path.to_s, mounted_as, model)
  end

end
