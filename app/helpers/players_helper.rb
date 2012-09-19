require "base64"
require "encryptor"
Encryptor.default_options.merge!(:key => Digest::SHA256.hexdigest('very secret'))

module PlayersHelper

  def url_safe_encode value
    Base64.urlsafe_encode64(Encryptor.encrypt(value))
  end

  def url_safe_decode value
    Encryptor.decrypt(Base64.urlsafe_decode64(value))
  end

end
