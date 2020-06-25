require 'test_helper'

class RekapControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rekap_index_url
    assert_response :success
  end

end
