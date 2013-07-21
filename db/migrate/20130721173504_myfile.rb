class Myfile < ActiveRecord::Migration
  def change
    rename_column :encrypted_files, :file, :myfile
    rename_column :encrypted_files, :file_name, :myfile_name
    rename_column :encrypted_files, :file_content_type, :myfile_content_type
    rename_column :encrypted_files, :password, :myfile_password
  end
end
