class CreateEncryptedFiles < ActiveRecord::Migration
  def change
    create_table :encrypted_files do |t|
      t.string :file
      t.string :password

      t.timestamps
    end
  end
end
