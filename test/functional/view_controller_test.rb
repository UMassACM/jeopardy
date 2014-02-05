require 'test_helper'

class ViewControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
