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

  validates :time, :game_definition, :presence => true
  validates :time, :uniqueness => {:scope => :game_definition_id}

  belongs_to :game_definition

  has_many :player_games
  has_many :players, -> { order('player_games.created_at') }, :through => :player_games

  #Thursday 10-Jan-2013 08:00
  TIME_FORMAT = '%A %d-%b-%Y %H:%M'

  def time_formatted
    time.strftime(TIME_FORMAT)
  end

  # Mailer
  def self.send_notification_emails
    games = Game.where(emails_sent: false)
    games.each do |game|
      players = Player.all

      players.each do |player|
        PlayerMailer.notification_email(player, game).deliver
      end

      game.update_attribute(:emails_sent, true)
    end
  end

end
