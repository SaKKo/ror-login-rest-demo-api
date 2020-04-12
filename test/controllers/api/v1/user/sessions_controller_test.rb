require 'test_helper'

class Api::V1::User::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_user_sessions_create_url
    assert_response :success
  end

end
