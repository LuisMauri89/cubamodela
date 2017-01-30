require 'test_helper'

class ProfilePhotographersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get profile_photographers_index_url
    assert_response :success
  end

end
