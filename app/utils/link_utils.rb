require 'base64'
require 'encryptor'

Encryptor.default_options.merge!(:key => Digest::SHA256.hexdigest('verry cekrett'))

class LinkUtils

  HOST              = 'http://fmgr.herokuapp.com'
  SUBSCRIBE_PATH    = '/playergame/subscribe'
  UNSUBSCRIBE_PATH  = '/playergame/unsubscribe'

  class << self

    def subscribe_link(player_id, game_id)
      code = url_encode(create_link_hash(player_id, game_id))
      "#{HOST}#{SUBSCRIBE_PATH}/#{code}"
    end

    def unsubscribe_link(player_id, game_id)
      code = url_encode(create_link_hash(player_id, game_id))
      "#{HOST}#{UNSUBSCRIBE_PATH}/#{code}"
    end

    def url_encode(str_value)
      Base64.urlsafe_encode64(str_value)
    end

    def url_decode(str_value)
      Base64.urlsafe_decode64(str_value)
    end

    def create_link_hash(player_id, game_id)
      Encryptor.encrypt "#{player_id}|#{game_id}"
    end

    def decrypt_link_hash(link_hash)
      Encryptor.decrypt(link_hash).split('|')
    end

  end

end
