module Captchator
  module View    
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
end

class ActionView::Base
  include Captchator::View
end
