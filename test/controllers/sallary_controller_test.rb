require 'test_helper'

class SallaryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sallary_index_url
    assert_response :success
  end

end
