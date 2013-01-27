class GameInstance < ActiveRecord::Base
  attr_accessible :time, :game_definition, :emails_sent
  validates :time, :game_definition, :presence => true

  validates :time, :uniqueness => {:scope => :game_definition_id }

  belongs_to :game_definition

  has_many :player_game_instances
  has_many :players, :through => :player_game_instances

  #Thursday 10-Jan-2013 08:00
  def time_formatted
    time.strftime("%A %d-%b-%Y %H:%M")
  end

  # Mailer
  def self.send_notification_emails
    games_instances = GameInstance.where emails_sent: false
    games_instances.each do |game_instance|
      # TODO: change to: Player.all
      players = Player.find_all_by_surname 'Szlachta'

      # TODO: background job to send emails
      players.each do |player|
        PlayerMailer.notification_email(player, game_instance).deliver
      end

      game_instance.update_attribute :emails_sent, true
    end
  end

end
