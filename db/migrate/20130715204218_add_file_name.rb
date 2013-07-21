class AddFileName < ActiveRecord::Migration
  def change
    add_column :encrypted_files, :file_name, :string
  end
end
