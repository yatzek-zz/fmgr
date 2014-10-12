describe 'Game' do

  it 'has a valid factory' do
    expect(create(:game)).to be_valid
  end

  it 'is invalid without a time' do
    expect(build(:game, time: nil)).to_not be_valid
  end

  it 'is invalid without a game_definition' do
    expect(build(:game, game_definition: nil)).to_not be_valid
  end

  it 'is unique for game_definition and time' do
    game_definition = create(:game_definition)
    time = game_definition.next_game_time

    create(:game, game_definition: game_definition, time: time)
    expect(build(:game, game_definition: game_definition, time: time)).not_to be_valid
  end

  describe 'has periodic game subscription job which' do

    it 'does not send emails to players if there are no game instances' do
      Game.send_notification_emails
      expect(email_deliveries).to be_empty
    end

    it 'does not send emails to players for a game for which emails have already been sent' do
      game_definition = create(:game_definition)
      create(:game, game_definition: game_definition,
             time: game_definition.next_game_time,
             emails_sent: true)
      create(:szlachta)

      Game.send_notification_emails

      expect(email_deliveries).to be_empty
    end

    it 'sends emails to players for a new game instance' do
      game_definition = create(:game_definition)
      game = create(:game, game_definition: game_definition, time: game_definition.next_game_time)
      szlachta = create(:szlachta)

      Game.send_notification_emails

      expect(last_email.to).to include szlachta.email
      game.reload
      expect(game.emails_sent).to eq true
    end

  end

  describe 'has periodic game reminder job which' do

    after(:each) { Timecop.return }

    it 'sends reminder emails to players for games to be played next day' do
      time_14_10_2013_15_00 = Time.local(2013, 10, 14, 15, 0, 0)
      time_15_10_2013_12_00 = Time.local(2013, 10, 15, 12, 0, 0)

      Timecop.freeze time_14_10_2013_15_00
      game_definition = create(:game_definition)
      game = create(:game, game_definition: game_definition, time: time_15_10_2013_12_00)

      10.times do
        create(:player_game, player: create(:iniesta), game: game)
      end

      # using double here to test reserve flag is being passed correctly to the mailer
      mail_double = double()
      expect(mail_double).to receive(:deliver).exactly(10).times
      expect(GameReminderMailer).to receive(:reminder_email).with(anything, game, false).exactly(10).times.and_return(mail_double)

      Game.send_game_reminders
    end

    it 'does not send reminder emails to players for games already played' do
      time_15_10_2013_15_00 = Time.local(2013, 10, 15, 15, 0, 0)
      time_15_10_2013_12_00 = Time.local(2013, 10, 15, 12, 0, 0)

      Timecop.freeze time_15_10_2013_15_00
      game_definition = create(:game_definition)
      game = create(:game, game_definition: game_definition, time: time_15_10_2013_12_00)
      szlachta = create(:szlachta)
      create(:player_game, player: szlachta, game: game)

      Game.send_game_reminders
      expect(email_deliveries).to be_empty
    end

    it 'does not send reminder emails to players for games to be played later than next day' do
      time_13_10_2013_15_00 = Time.local(2013, 10, 13, 15, 0, 0)
      time_15_10_2013_12_00 = Time.local(2013, 10, 15, 12, 0, 0)

      Timecop.freeze time_13_10_2013_15_00
      game_definition = create(:game_definition)
      game = create(:game, game_definition: game_definition, time: time_15_10_2013_12_00)
      szlachta = create(:szlachta)
      create(:player_game, player: szlachta, game: game)

      Game.send_game_reminders
      expect(email_deliveries).to be_empty
    end

  end

  context 'scopes' do

    before(:all) do
      @time_10_01_2013_11_00 = Time.local(2013, 1, 10, 11, 0, 0)
      @time_10_01_2013_13_00 = Time.local(2013, 1, 10, 13, 0, 0)
      @time_17_01_2013_13_00 = Time.local(2013, 1, 17, 13, 0, 0)
    end
    after(:each) { Timecop.return }

    describe 'future_by_date scope' do
      it 'shows only future games' do
        Timecop.freeze @time_10_01_2013_13_00
        game_definition = create(:game_definition)
        create(:game, game_definition: game_definition, time: @time_10_01_2013_11_00)
        create(:game, game_definition: game_definition, time: @time_17_01_2013_13_00)

        expect(Game.in_the_future_by_date.size).to eq 1
      end

      it 'ordered by date with the closest game at the top of the list' do
        Timecop.freeze @time_10_01_2013_11_00
        game_definition = create(:game_definition)
        create(:game, game_definition: game_definition, time: @time_10_01_2013_13_00)
        create(:game, game_definition: game_definition, time: @time_17_01_2013_13_00)

        future_games = Game.in_the_future_by_date
        expect(future_games.size).to eq 2

        expect(future_games.first.time).to eq @time_10_01_2013_13_00
        expect(future_games.last.time).to eq @time_17_01_2013_13_00
      end
    end

    describe 'all_by_date scope' do
      it 'ordered by date with the closest game at the top of the list' do
        game_definition = create(:game_definition)
        create(:game, game_definition: game_definition, time: @time_10_01_2013_11_00)
        create(:game, game_definition: game_definition, time: @time_10_01_2013_13_00)
        create(:game, game_definition: game_definition, time: @time_17_01_2013_13_00)

        all_by_date = Game.all_by_date
        expect(all_by_date.size).to eq 3

        expect(all_by_date.first.time).to eq @time_17_01_2013_13_00
        expect(all_by_date.second.time).to eq @time_10_01_2013_13_00
        expect(all_by_date.third.time).to eq @time_10_01_2013_11_00
      end
    end
  end


end
