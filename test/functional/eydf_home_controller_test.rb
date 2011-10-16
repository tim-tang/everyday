require 'test_helper'

class EydfHomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show_blog" do
    get :show_blog
    assert_response :success
  end

end
