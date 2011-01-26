class ActionController::Base
  include Captchator::Controller
  helper_method :captchator_session_id
end