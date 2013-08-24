class AddMyfileSize < ActiveRecord::Migration
  def change
    add_column :encrypted_files, :myfile_size, :integer
  end
end
