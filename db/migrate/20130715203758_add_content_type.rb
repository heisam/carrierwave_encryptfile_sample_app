class AddContentType < ActiveRecord::Migration
  def change
    add_column :encrypted_files, :file_content_type, :string
  end
end
