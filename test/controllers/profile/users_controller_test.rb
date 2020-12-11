require 'test_helper'

class Profile::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get block_index" do
    get profile_users_block_index_url
    assert_response :success
  end

end
