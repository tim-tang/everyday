require 'test_helper'

class EydfGuestbkControllerTest < ActionController::TestCase
  test "should get guest_list" do
    get :guest_list
    assert_response :success
  end

end
