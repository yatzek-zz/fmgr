
describe 'PlayerGame' do

  let(:game) {create :game}
  let(:messi) {create :messi}

  it 'has valid factory' do
    expect(create(:player_game, player: messi, game: game)).to be_valid
  end

  it 'is unique for player/game' do
    expect(create(:player_game, player: messi, game: game)).to be_valid
    expect(build(:player_game, player: messi, game: game)).not_to be_valid
  end

end
