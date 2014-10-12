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

  #e.g. Thursday 10-Jan-2013 08:00
  TIME_FORMAT = '%A %d-%b-%Y %H:%M'
  MIN_NUM_OF_PLAYERS = 10

  validates :time, :game_definition, :presence => true
  validates :time, :uniqueness => {:scope => :game_definition_id}
  attr_default :emails_sent, false

  belongs_to :game_definition

  has_many :player_games
  has_many :players, -> { order('player_games.created_at ASC') }, :through => :player_games

  scope :in_the_future_by_date, -> { where('time > ?', Time.now).order('time ASC') }
  scope :all_by_date, -> { order('time DESC') }

  def time_formatted
    time.strftime(TIME_FORMAT)
  end

  # Mailers

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

  def self.send_game_reminders
    tomorrow = Time.now + 1.day
    tomorrow_games = Game.where('time > ? and time < ?', tomorrow.beginning_of_day, tomorrow.end_of_day)

    tomorrow_games.each do |game|
      game_players = game.players

      if game_players.size >= MIN_NUM_OF_PLAYERS
        game_players.each_with_index do |player, index|
          is_reserve = PlayerGame.is_reserve_player?(index, game_players.size)
          GameReminderMailer.reminder_email(player, game, is_reserve).deliver
        end
      end

    end

  end

end
