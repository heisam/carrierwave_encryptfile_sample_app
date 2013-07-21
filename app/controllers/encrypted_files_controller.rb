class EncryptedFilesController < ApplicationController
  before_action :set_encrypted_file, only: [:show, :edit, :update, :destroy, :download]

  # GET /encrypted_files
  # GET /encrypted_files.json
  def index
    @encrypted_files = EncryptedFile.all
  end

  # GET /encrypted_files/1
  # GET /encrypted_files/1.json
  def show
  end

  # GET /encrypted_files/new
  def new
    @encrypted_file = EncryptedFile.new
  end

  # GET /encrypted_files/1/edit
  def edit
  end

  # POST /encrypted_files
  # POST /encrypted_files.json
  def create
    @encrypted_file = EncryptedFile.new(encrypted_file_params)

    respond_to do |format|
      if @encrypted_file.save
        format.html { redirect_to @encrypted_file, notice: 'Encrypted file was successfully created.' }
        format.json { render action: 'show', status: :created, location: @encrypted_file }
      else
        format.html { render action: 'new' }
        format.json { render json: @encrypted_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /encrypted_files/1
  # PATCH/PUT /encrypted_files/1.json
  def update
    respond_to do |format|
      if @encrypted_file.update(encrypted_file_params)
        format.html { redirect_to @encrypted_file, notice: 'Encrypted file was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @encrypted_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /encrypted_files/1
  # DELETE /encrypted_files/1.json
  def destroy
    @encrypted_file.destroy
    respond_to do |format|
      format.html { redirect_to encrypted_files_url }
      format.json { head :no_content }
    end
  end


  def download
    send_encrypted_file(@encrypted_file, :myfile, :inline)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_encrypted_file
      @encrypted_file = EncryptedFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def encrypted_file_params
      params.require(:encrypted_file).permit(:myfile)
    end

    def send_encrypted_file(resource, file_field, disposition='attachment', version=nil)
      # get the decrypted file from the server.  needs the uploader model, the record the file is
      # attached to in your ORM, and the actual field name (as a symbol or a string) that the file
      # is stored.
      decrypted_file = CarrierWave::EncryptFile::Downloader.call(resource, file_field, version)
      # decrypted file is a hash set up as follows:
      # decrypted_file[:file] - the decrypted file, hopefully saved in a tmp path, not somewhere
      # public-facing.
      # decrypted_file[:content_type] - returns content type, if available.
      # send the file to the user:
      send_file decrypted_file[:file], :type => decrypted_file[:content_type], :disposition => disposition , :filename => resource.send("#{file_field}_name")
      # then immediately destroy the file.  You don't want an unencrypted file saved on your
      # server... or do you?
      File.unlink decrypted_file[:file] unless Rails.env.development?
    end
end