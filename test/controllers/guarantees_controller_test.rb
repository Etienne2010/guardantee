require 'test_helper'

class GuaranteesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get guarantees_index_url
    assert_response :success
  end

end
