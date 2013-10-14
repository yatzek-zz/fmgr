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

    after(:each) {Timecop.return}

    it 'shows only future games' do
      Timecop.freeze @time_10_01_2013_13_00
      game_definition = create(:game_definition)
      create(:game, game_definition: game_definition, time: @time_10_01_2013_11_00)
      create(:game, game_definition: game_definition, time: @time_17_01_2013_13_00)

      Game.future_by_date.size.should == 1
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
    end

  end

  describe 'has periodic game subscription job which' do

    it 'does not send emails to players if there are no game instances' do
      Game.send_notification_emails
      email_deliveries.should be_empty
    end

    it 'does not send emails to players for a game for which emails have already been sent' do
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

  describe 'has periodic game reminder job which' do

    after(:each) {Timecop.return}

    it 'sends reminder emails to players for games to be played next day' do
      time_14_10_2013_15_00 = Time.local(2013, 10, 14, 15, 0, 0)
      time_15_10_2013_12_00 = Time.local(2013, 10, 15, 12, 0, 0)

      Timecop.freeze time_14_10_2013_15_00
      game_definition = create(:game_definition)
      game = create(:game, game_definition: game_definition, time: time_15_10_2013_12_00)
      iniesta = create(:iniesta)
      szlachta = create(:szlachta)
      create(:player_game, player: iniesta, game: game)
      create(:player_game, player: szlachta, game: game)

      # using double here to test reserve flag is being passed correctly to the mailer
      mail_double = double()
      mail_double.should_receive(:deliver).twice
      GameReminderMailer.should_receive(:reminder_email).with(iniesta, game, false).and_return(mail_double)
      GameReminderMailer.should_receive(:reminder_email).with(szlachta, game, true).and_return(mail_double)

      Game.send_game_reminders(1)
    end

    it 'does not send reminder emails to players for games already played' do
      time_15_10_2013_15_00 = Time.local(2013, 10, 15, 15, 0, 0)
      time_15_10_2013_12_00 = Time.local(2013, 10, 15, 12, 0, 0)

      Timecop.freeze time_15_10_2013_15_00
      game_definition = create(:game_definition)
      game = create(:game, game_definition: game_definition, time: time_15_10_2013_12_00)
      szlachta = create(:szlachta)
      create(:player_game, player: szlachta, game: game)

      Game.send_game_reminders(1)
      email_deliveries.should be_empty
    end

    it 'does not send reminder emails to players for games to be played later than next day' do
      time_13_10_2013_15_00 = Time.local(2013, 10, 13, 15, 0, 0)
      time_15_10_2013_12_00 = Time.local(2013, 10, 15, 12, 0, 0)

      Timecop.freeze time_13_10_2013_15_00
      game_definition = create(:game_definition)
      game = create(:game, game_definition: game_definition, time: time_15_10_2013_12_00)
      szlachta = create(:szlachta)
      create(:player_game, player: szlachta, game: game)

      Game.send_game_reminders(1)
      email_deliveries.should be_empty
    end

  end

end
