require 'spec_helper'

describe GameInstance do

  it "has a valid factory" do
    create(:game_instance).should be_valid
  end

  it "is invalid without a time" do
    build(:game_instance, time: nil).should_not be_valid
  end

  it "is invalid without a game_definition" do
    build(:game_instance, game_definition: nil).should_not be_valid
  end

  it "is unique for game_definition and time" do
    game_definition = create(:game_definition)
    time = game_definition.next_game_time

    create(:game_instance, game_definition: game_definition, time: time)
    build(:game_instance, game_definition: game_definition, time: time).should_not be_valid
  end

  describe "has periodic job which" do

    it "does not send emails to players if there are no game instances" do
      GameInstance.send_notification_emails
      email_deliveries.should be_empty
    end

    it "does not send emails to players for an old game instance" do
      game_definition = create(:game_definition)
      create(:game_instance, game_definition: game_definition,
                             time: game_definition.next_game_time,
                             emails_sent: true)
      create(:szlachta)

      GameInstance.send_notification_emails

      email_deliveries.should be_empty
    end

    it "sends emails to players for a new game instance" do
      game_definition = create(:game_definition)
      game_instance = create(:game_instance, game_definition: game_definition, time: game_definition.next_game_time)
      szlachta = create(:szlachta)

      GameInstance.send_notification_emails

      last_email.to.should include szlachta.email
      game_instance.reload
      game_instance.emails_sent.should be_true
    end

  end

end
