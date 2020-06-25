require 'test_helper'

class AbsentControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get absent_index_url
    assert_response :success
  end

end
