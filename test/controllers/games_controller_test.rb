require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  test "should get archive" do
    get :archive
    assert_response :success
  end

end
