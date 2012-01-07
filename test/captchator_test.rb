require 'test_helper'

class CaptchatorTest < ActiveSupport::TestCase
  
  include Captchator::View
  
  test "truth" do
    assert_kind_of Module, Captchator
  end
  
  test "save with captchator with valid record and invalid captcha" do
    User.any_instance.stubs(:valid?).returns(true)
    ApplicationController.any_instance.stubs(:verify_captchator).returns(false)
    @controller = ApplicationController.new
    user = User.new
    assert !@controller.save_with_captchator(user)
    assert_equal ['Captchator thinks you are a robot.  Please try again.'], user.errors[:base]
  end
  
end
