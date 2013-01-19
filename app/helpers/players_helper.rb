require "base64"
require "encryptor"

Encryptor.default_options.merge!(:key => Digest::SHA256.hexdigest('verry cekrett'))

module PlayersHelper

  def url_safe_encode str_value
    Base64.urlsafe_encode64(Encryptor.encrypt(str_value))
  end

  def url_safe_decode value
    Encryptor.decrypt(Base64.urlsafe_decode64(value))
  end

  def create_link_hash player_id, game_instance_id
    Encryptor.encrypt "#{player_id}|#{game_instance_id}", key: SECRET_KEY
  end

  def decrypt_link_hash link_hash
    Encryptor.decrypt(link_hash, key: SECRET_KEY).split '|'
  end

end
