class Player < ActiveRecord::Base

  validates :name, :surname, :presence => true,   :length => {:minimum => 2}
  validates :email,          :uniqueness => true, :length => {:minimum => 4}

  # to fix the following issue when running: rake db:seed
  # rake aborted!
  # Can't mass-assign protected attributes: name, surname, email
  attr_accessible :name, :surname, :email


  has_many :player_games
  has_many :games, :through => :player_games

  # scopes and finders?
  # test them
end
