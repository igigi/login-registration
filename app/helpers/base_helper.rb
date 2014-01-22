class BaseHelper

  class << self
    def is_phone? phone
      if phone.blank?
        false
      else
        true
      end
    end

    def is_captcha? captcha
      if captcha.blank?
        false
      else
        true
      end
    end
  end
end