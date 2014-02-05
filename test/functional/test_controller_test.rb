require 'test_helper'

class TestControllerTest < ActionController::TestCase
  test "should get created" do
    get :created
    assert_response :success
  end

end
