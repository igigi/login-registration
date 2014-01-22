class SessionsApi < BaseApi

  post '/captcha' do
    unless BaseHelper.is_phone? params[:phone]
      json error: { code: 101, content: 'Invalid phone number.' }
    else
      json content: Captcha.generate_for(User.find_or_create(params[:phone])).content
    end
  end
  
  post '/signin' do
    if not BaseHelper.is_phone? params[:phone]
      json error: { code: 101, content: 'Invalid phone number.' }
    elsif not BaseHelper.is_captcha? params[:captcha]
      json error: { code: 102, content: 'Invalid captcha.' }
    else
      user = User.where(phone: params[:phone]).first
      if user.blank?
        json error: { code: 103, content: 'Unknown phone number.' }
      else
        captcha = Captcha.where(content: params[:captcha]).first
        if captcha.blank?
          json error: { code: 104, content: 'Wrong captcha.' }
        else
          if not captcha.is_valid_for? user
            json error: { code: 105, content: 'Expired captcha.' }
          else
            captcha.expire!
            json content: Token.generate_for(user).content
          end
        end
      end
    end
  end
end