require "encryptor"

class Player < ActiveRecord::Base

  validates :name, :surname, :presence => true,   :length => {:minimum => 2}
  validates :email,          :uniqueness => true, :length => {:minimum => 4}

  # to fix the following issue when running: rake db:seed
  # rake aborted!
  # Can't mass-assign protected attributes: name, surname, email
  attr_accessible :name, :surname, :email


  has_many :player_game_instances
  has_many :game_instances, :through => :player_game_instances

  # scopes and finders?
  # test them

  SECRET_KEY = Digest::SHA256.hexdigest('cekrett')

  # TODO: move these two methods somewhere else?
  def self.create_link_hash player_id, game_instance_id
    Encryptor.encrypt "#{player_id}|#{game_instance_id}", key: SECRET_KEY
  end

  def self.decrypt_link_hash link_hash
    Encryptor.decrypt(link_hash, key: SECRET_KEY).split '|'
  end

end
