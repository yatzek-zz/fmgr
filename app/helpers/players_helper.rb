require "base64"
require "encryptor"
Encryptor.default_options.merge!(:key => Digest::SHA256.hexdigest('very secret'))

module PlayersHelper

  def url_safe_encode str_value
    Base64.urlsafe_encode64(Encryptor.encrypt(str_value))
  end

  def url_safe_decode value
    Encryptor.decrypt(Base64.urlsafe_decode64(value))
  end

end
