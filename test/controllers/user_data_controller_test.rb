require 'test_helper'

class UserDataControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_data_index_url
    assert_response :success
  end

end
