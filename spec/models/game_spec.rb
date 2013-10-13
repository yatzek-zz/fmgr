
describe 'Game' do

  it 'has a valid factory' do
    create(:game).should be_valid
  end

  it 'is invalid without a time' do
    build(:game, time: nil).should_not be_valid
  end

  it 'is invalid without a game_definition' do
    build(:game, game_definition: nil).should_not be_valid
  end

  it 'is unique for game_definition and time' do
    game_definition = create(:game_definition)
    time = game_definition.next_game_time

    create(:game, game_definition: game_definition, time: time)
    build(:game, game_definition: game_definition, time: time).should_not be_valid
  end


  describe 'future_by_date scope' do

    before(:all) do
      @time_10_01_2013_11_00 = Time.local(2013, 1, 10, 11, 0, 0)
      @time_10_01_2013_13_00 = Time.local(2013, 1, 10, 13, 0, 0)
      @time_17_01_2013_13_00 = Time.local(2013, 1, 17, 13, 0, 0)
    end

    it 'shows only future games' do
      Timecop.freeze @time_10_01_2013_13_00
      game_definition = create(:game_definition)
      create(:game, game_definition: game_definition, time: @time_10_01_2013_11_00)
      create(:game, game_definition: game_definition, time: @time_17_01_2013_13_00)

      Game.future_by_date.size.should == 1
      Timecop.return
    end

    it 'ordered by date with the closest game at the top of the list' do
      Timecop.freeze @time_10_01_2013_11_00
      game_definition = create(:game_definition)
      create(:game, game_definition: game_definition, time: @time_10_01_2013_13_00)
      create(:game, game_definition: game_definition, time: @time_17_01_2013_13_00)

      future_games = Game.future_by_date
      future_games.size.should == 2

      future_games.first.time.should == @time_10_01_2013_13_00
      future_games.last.time.should == @time_17_01_2013_13_00
      Timecop.return
    end

  end

  describe 'has periodic job which' do

    it 'does not send emails to players if there are no game instances' do
      Game.send_notification_emails
      email_deliveries.should be_empty
    end

    it 'does not send emails to players for an old game instance' do
      game_definition = create(:game_definition)
      create(:game, game_definition: game_definition,
                    time: game_definition.next_game_time,
                    emails_sent: true)
      create(:szlachta)

      Game.send_notification_emails

      email_deliveries.should be_empty
    end

    it 'sends emails to players for a new game instance' do
      game_definition = create(:game_definition)
      game = create(:game, game_definition: game_definition, time: game_definition.next_game_time)
      szlachta = create(:szlachta)

      Game.send_notification_emails

      last_email.to.should include szlachta.email
      game.reload
      game.emails_sent.should be_true
    end

  end

end
