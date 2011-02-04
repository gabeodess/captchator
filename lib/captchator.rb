# Captchator

module Captchator  
  # ========
  # = View =
  # ========
  module View
    module ClassMethods

    end

    module InstanceMethods
      def captchator_instructions
        ENV['captchator_instructions'] || "Please write the text shown in the captcha box to prove you're not a machine."
      end
      
      def captchator_tags
        captchator_label + captchator_input + captchator_refresh
      end
      
      def captchator_label
        label_tag('captchator_answer', captchator_image)
      end
      
      def captchator_input
        text_field_tag(:captchator_answer)
      end
      
      def captchator_refresh
        link_to("refresh captcha", {:anchor => 'captchaptor_image'}, {
          :id => 'captchator_refresh',
          :onclick => <<-JAVASCRIPT
var new_url = "#{captchator_image_path}?" + (new Date).getTime();
$('#captchator_image').attr('src', new_url);
return false;
          JAVASCRIPT
        })
      end
            
      def captchator_image_path
        File.join("http://captchator.com/captcha/image", captchator_session_id)
      end
      
      def captchator_image
<<-HTML
<img src="#{captchator_image_path}" id="captchator_image" />
HTML
      end
    end

    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
  
  # ==============
  # = Controller =
  # ==============
  module Controller
    module ClassMethods
      
    end
    
    module InstanceMethods
      # => Accepts the following options: message.
      def save_with_captchator(record, options = {})
        message = options[:message] || "Captchator thinks you are a robot.  Please try again."
        return record.save unless record.valid?
        if !verify_captchator
          record.errors.add_to_base(message)
          return false
        else
          return record.save
        end
      end
      
      def captchator_session_id
        ENV['captchator_session_id'] || session[:session_id]
      end

      def verify_captchator
        return captchator_test if Rails.env.test?
        open("http://captchator.com/captcha/check_answer/#{captchator_session_id}/#{params[:captchator_answer]}").read == '1'
      end
      
      def captchator_test
        true
      end
    end
    
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
end