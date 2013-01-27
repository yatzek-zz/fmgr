require "base64"
require "encryptor"

Encryptor.default_options.merge!(:key => Digest::SHA256.hexdigest('verry cekrett'))

module PlayersHelper

  def subscribe_link player_id, game_instance_id
    code = url_safe_encode(create_link_hash(player_id, game_instance_id))
    "http://fmgr.herokuapp.com/play/subscribe/#{code}"
  end

  def unsubscribe_link player_id, game_instance_id
    code = url_safe_encode(create_link_hash(player_id, game_instance_id))
    "http://fmgr.herokuapp.com/play/unsubscribe/#{code}"
  end

  def url_safe_encode str_value
    Base64.urlsafe_encode64(str_value)
  end

  def url_safe_decode str_value
    Base64.urlsafe_decode64(str_value)
  end

  def create_link_hash player_id, game_instance_id
    Encryptor.encrypt "#{player_id}|#{game_instance_id}"
  end

  def decrypt_link_hash link_hash
    Encryptor.decrypt(link_hash).split '|'
  end

end
