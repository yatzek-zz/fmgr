
describe 'GameDefinition' do

  it 'has a valid factory' do
    expect(create(:game_definition)).to be_valid
  end

  it 'is invalid without a day' do
    expect(build(:game_definition, day: nil)).not_to be_valid
  end

  it 'is invalid without a time' do
    expect(build(:game_definition, time: nil)).not_to be_valid
  end

  it 'is unique for date and time' do
    create(:game_definition)
    expect(build(:game_definition)).not_to be_valid
  end

  describe 'has periodic job which:' do

    TIME_10_01_2013_11_00 = Time.local(2013, 1, 10, 11, 0, 0)
    TIME_10_01_2013_13_00 = Time.local(2013, 1, 10, 13, 0, 0)
    TIME_17_01_2013_13_00 = Time.local(2013, 1, 17, 13, 0, 0)

    after(:each) do
      Timecop.return
    end

    it 'does not create next game instance if not withing creation period' do
      @tue_12_00_game = create :game_definition
      Timecop.freeze TIME_10_01_2013_11_00 # more than 5 days before the game, next game: 15.01.2013 12:00
      GameDefinition.create_games

      expect(Game.all).to be_empty
    end

    it 'does not create next game instance if within creation period and none exists but game definition is disabled' do
      @tue_12_00_game = create(:game_definition, disabled: true)
      Timecop.freeze TIME_10_01_2013_13_00 # less than 5 days before the game, next game: 15.01.2013 12:00
      GameDefinition.create_games

      expect(Game.all).to be_empty
    end

    it 'creates next game instance if within creation period and none exists but game definition is disabled - override flag' do
      @tue_12_00_game = create(:game_definition, disabled: true)
      Timecop.freeze TIME_10_01_2013_13_00 # less than 5 days before the game, next game: 15.01.2013 12:00
      GameDefinition.create_games(true)

      expect(Game.all.size).to eq 1
      game = Game.first
      expect(game.game_definition).to eq @tue_12_00_game
      expect(game.time).to eq @tue_12_00_game.next_game_time
    end

    it 'creates next game instance if within creation period and none exists' do
      @tue_12_00_game = create :game_definition
      Timecop.freeze TIME_10_01_2013_13_00 # less than 5 days before the game, next game: 15.01.2013 12:00
      GameDefinition.create_games

      expect(Game.all.size).to eq 1
      game = Game.first
      expect(game.game_definition).to eq @tue_12_00_game
      expect(game.time).to eq @tue_12_00_game.next_game_time
    end

    it 'does not create next game instance if within creation period and game instance exists' do
      @tue_12_00_game = create :game_definition
      Timecop.freeze TIME_10_01_2013_13_00 # less than 5 days before the game, next game: 15.01.2013 12:00
      create(:game, game_definition: @tue_12_00_game, time: @tue_12_00_game.next_game_time)

      expect(Game.all.size).to eq 1

      GameDefinition.create_games

      expect(Game.all.size).to eq 1
    end

    it 'creates next game instance if within creation period and past week game instance exists' do
      @tue_12_00_game = create :game_definition
      Timecop.freeze TIME_10_01_2013_13_00 # less than 5 days before the game, next game: 15.01.2013 12:00
      first_game_time = @tue_12_00_game.next_game_time
      create(:game, game_definition: @tue_12_00_game, time: first_game_time)

      expect(Game.all.size).to eq 1
      Timecop.freeze TIME_17_01_2013_13_00 # move one week forward

      GameDefinition.create_games

      games = Game.all
      expect(games.size).to eq 2
      games.each { |g_i| expect(g_i.game_definition).to eq @tue_12_00_game }

      expect(Game.first.time).to eq first_game_time
      expect(Game.last.time).to eq @tue_12_00_game.next_game_time
    end

  end

end
