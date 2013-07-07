# == Schema Information
#
# Table name: games
#
#  id                 :integer          not null, primary key
#  game_definition_id :integer
#  time               :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  emails_sent        :boolean          default(FALSE)
#

class Game < ActiveRecord::Base
  attr_accessible :time, :game_definition, :emails_sent
  validates :time, :game_definition, :presence => true

  validates :time, :uniqueness => {:scope => :game_definition_id }

  belongs_to :game_definition

  has_many :player_games
  has_many :players, :through => :player_games, :uniq => true #, :order => 'player_games.created_at DESC'

  #Thursday 10-Jan-2013 08:00
  TIME_FORMAT = '%A %d-%b-%Y %H:%M'

  def time_formatted
    time.strftime(TIME_FORMAT)
  end

  # Mailer
  def self.send_notification_emails
    games = Game.where emails_sent: false
    games.each do |game|
      # TODO: change to: Player.all
      players = Player.find_all_by_surname 'Szlachta'

      # TODO: background job to send emails
      players.each do |player|
        PlayerMailer.notification_email(player, game).deliver
      end

      game.update_attribute :emails_sent, true
    end
  end

end
