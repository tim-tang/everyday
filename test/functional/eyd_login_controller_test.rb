require 'test_helper'

class EydLoginControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get authentication" do
    get :authentication
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

end
