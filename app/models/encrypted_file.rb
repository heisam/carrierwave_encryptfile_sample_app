class EncryptedFile < ActiveRecord::Base

  mount_uploader :myfile, EncryptedFileUploader

  validates_presence_of :myfile

  before_validation :set_file_name
  before_save :update_file_attributes

  private

  def set_file_name
    self.myfile_name = self.myfile.original_file
  end

  def update_file_attributes
    if myfile.present? && myfile_changed?
      self.myfile_content_type = myfile.file.content_type
      #self.myfile_size = myfile.file.size
    end
  end

end
