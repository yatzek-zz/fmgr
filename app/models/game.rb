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
  TIME_FORMAT = '%A %d %b %Y at %H:%M'
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
  class << self

    def send_notification_emails
      games = Game.where(emails_sent: false)
      games.each do |game|
        players = Player.all

        players.each do |player|
          PlayerMailer.notification_email(player, game).deliver
        end

        game.update_attribute(:emails_sent, true)
      end
    end

    def send_game_reminders
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

    def delete_old
      # TODO
      # cascade delete of games and player_games older than a year.
    end


    TOTAL_PRICE = BigDecimal.new('38.00')

    def price_per_player(all_subscribed)
      num_of_players = num_of_playing_players(all_subscribed)
      sprintf('£%.2f', (TOTAL_PRICE / num_of_players).ceil(1))
    end

    def num_of_playing_players(all_subscribed)
      raise 'Num of players has to be grater or equal 10!' if all_subscribed < 10

      case all_subscribed
        when 10
          10
        when 11
          10
        when 12
          12
        when 13
          12
        else
          14
      end
    end

    def send_payment_reminders
      now = Time.now
      games_played_today = Game.where('time > ? and time < ?', now.beginning_of_day, now)

      games_played_today.each do |game|
        game_players = game.players

        if game_players.size >= MIN_NUM_OF_PLAYERS
          price = price_per_player(game_players.size)
          game_players.each_with_index do |player, index|
            is_reserve = PlayerGame.is_reserve_player?(index, game_players.size)
            unless is_reserve
              PaymentReminderMailer.payment_reminder_email(player, game, price).deliver
            end
          end
        end
      end

    end

  end

end
