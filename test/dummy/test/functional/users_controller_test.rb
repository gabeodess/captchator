require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "testing view" do
    get :new
    assert_match "http://captchator.com/captcha/image", @response.body
  end

end
