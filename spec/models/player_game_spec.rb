describe PlayerGame do

  let(:game) {create :game}
  let(:messi) {create :messi}

  it 'has valid factory' do
    expect(create(:player_game, player: messi, game: game)).to be_valid
  end

  it 'is unique for player/game' do
    expect(create(:player_game, player: messi, game: game)).to be_valid
    expect(build(:player_game, player: messi, game: game)).not_to be_valid
  end

  context 'is_reseerve_player?' do

    context 'one to ten players' do

      it "all are 'base-player'" do
        (0..9).each do |index|
          ((index+1)..10).each do |all_players|
            expect(PlayerGame.is_reserve_player?(index, all_players)).to eq false
          end
        end
      end

    end

    context 'eleven to fourteen players' do

      it "last is 'reserve-player' if there are 11 players" do
        expect(PlayerGame.is_reserve_player?(10, 11)).to eq true
      end

      it "all are 'base-player' if there are 12 players" do
        expect(PlayerGame.is_reserve_player?(10, 12)).to eq false
        expect(PlayerGame.is_reserve_player?(11, 12)).to eq false
      end

      it "last is 'reserve-player' if there are 13 players" do
        expect(PlayerGame.is_reserve_player?(10, 13)).to eq false
        expect(PlayerGame.is_reserve_player?(11, 13)).to eq false
        expect(PlayerGame.is_reserve_player?(12, 13)).to eq true
      end

      it "all are 'base-player' if there are 14 players" do
        expect(PlayerGame.is_reserve_player?(10, 14)).to eq false
        expect(PlayerGame.is_reserve_player?(11, 14)).to eq false
        expect(PlayerGame.is_reserve_player?(12, 14)).to eq false
        expect(PlayerGame.is_reserve_player?(13, 14)).to eq false
      end

    end

    context 'more than fourteen players' do

      it "15 and above are 'reserve-player'" do
        (0..13).each do |index|
          expect(PlayerGame.is_reserve_player?(index, 14)).to eq false
        end

        (14..19).each do |index|
          ((index+1)..20).each do |all_players|
            expect(PlayerGame.is_reserve_player?(index, all_players)).to eq true
          end
        end
      end

    end

  end

end
