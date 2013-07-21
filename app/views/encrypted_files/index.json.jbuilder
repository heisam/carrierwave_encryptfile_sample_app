json.array!(@encrypted_files) do |encrypted_file|
  json.extract! encrypted_file, :myfile, :password
  json.url encrypted_file_url(encrypted_file, format: :json)
end
