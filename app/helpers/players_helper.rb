require "base64"
require "encryptor"
Encryptor.default_options.merge!(:key => Digest::SHA256.hexdigest('very secret'))

module PlayersHelper

  def url_safe_encode value
    Base64.urlsafe_encode64(value.encrypt)
  end

  def url_safe_decode value
    Base64.urlsafe_decode64(value).decrypt
  end

end
