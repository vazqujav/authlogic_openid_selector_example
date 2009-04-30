class User < ActiveRecord::Base
  acts_as_authentic do |c| 
    c.validate_login_field = false
    # optional, but if you register by openid, i want you at least to share your email-address
    c.validate_email_field = true
    # fetch the email either by sreg or ax
    c.required_fields = [:email,"http://axschema.org/contact/email"]
  end
  
  private
  
  def map_openid_registration(registration)
    unless registration[:email].nil?
      self.email ||= registration[:email] if respond_to?(:email) && !registration[:email].blank?
    else
      self.email = registration['http://axschema.org/contact/email'].first unless registration['http://axschema.org/contact/email'].nil?
    end
  end
  
end