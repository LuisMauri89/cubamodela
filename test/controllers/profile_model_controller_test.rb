require 'test_helper'

class ProfileModelControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get profile_model_index_url
    assert_response :success
  end

  test "should get show" do
    get profile_model_show_url
    assert_response :success
  end

  test "should get new" do
    get profile_model_new_url
    assert_response :success
  end

  test "should get create" do
    get profile_model_create_url
    assert_response :success
  end

  test "should get edit" do
    get profile_model_edit_url
    assert_response :success
  end

  test "should get update" do
    get profile_model_update_url
    assert_response :success
  end

  test "should get destroy" do
    get profile_model_destroy_url
    assert_response :success
  end

end
