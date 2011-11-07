require 'test_helper'

class EydfIbookControllerTest < ActionController::TestCase
  test "should get ibook_list" do
    get :ibook_list
    assert_response :success
  end

end
