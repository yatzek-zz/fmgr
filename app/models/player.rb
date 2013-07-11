# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  surname    :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Player < ActiveRecord::Base

  #validates :name, :surname, :presence => false,   :length => {:minimum => 2}
  validates :email, :uniqueness => true, :length => {:minimum => 4}

  attr_accessible :name, :surname, :email

  has_many :player_games
  has_many :games, :through => :player_games, :uniq => true

  scope :sorted, :order => 'name, surname ASC'

end
