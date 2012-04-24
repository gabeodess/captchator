module Captchator
  module Controller

    # Accepts the following options: message.
    def save_with_captchator(record, options = {})
      message = options[:message] || "Captchator thinks you are a robot.  Please try again."
      return record.save unless record.valid?
      if !verify_captchator
        record.errors.add(:base, message)
        return false
      else
        return record.save
      end
    end
    
    def captchator_session_id
      @captchator_session_id ||= (ENV['captchator_session_id'] || session[:session_id] || "#{rand}".gsub(/[^\d]/, ''))
    end

    def verify_captchator
      return captchator_test if Rails.env.test?
      open("http://captchator.com/captcha/check_answer/#{captchator_session_id}/#{params[:captchator_answer]}").read == '1'
    end
    
    def captchator_test
      true
    end

  end
end

class ActionController::Base
  include Captchator::Controller
  helper_method :captchator_session_id
end
