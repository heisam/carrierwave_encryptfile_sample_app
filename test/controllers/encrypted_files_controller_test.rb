require 'test_helper'

class EncryptedFilesControllerTest < ActionController::TestCase
  setup do
    @encrypted_file = encrypted_files(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:encrypted_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create encrypted_file" do
    assert_difference('EncryptedFile.count') do
      post :create, encrypted_file: { file: @encrypted_file.file, password: @encrypted_file.password }
    end

    assert_redirected_to encrypted_file_path(assigns(:encrypted_file))
  end

  test "should show encrypted_file" do
    get :show, id: @encrypted_file
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @encrypted_file
    assert_response :success
  end

  test "should update encrypted_file" do
    patch :update, id: @encrypted_file, encrypted_file: { file: @encrypted_file.file, password: @encrypted_file.password }
    assert_redirected_to encrypted_file_path(assigns(:encrypted_file))
  end

  test "should destroy encrypted_file" do
    assert_difference('EncryptedFile.count', -1) do
      delete :destroy, id: @encrypted_file
    end

    assert_redirected_to encrypted_files_path
  end
end
