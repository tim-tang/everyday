require 'test_helper'

class EydfGalleryControllerTest < ActionController::TestCase
  test "should get gallery_list" do
    get :gallery_list
    assert_response :success
  end

end
