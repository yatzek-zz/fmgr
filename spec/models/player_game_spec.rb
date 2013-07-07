require 'spec_helper'

describe 'PlayerGame' do

  let(:game) {create :game}
  let(:messi) {create :messi}

  it 'has valid factory' do
    create(:player_game, player: messi, game: game).should be_valid
  end

  it 'is unique for player/game' do
    create(:player_game, player: messi, game: game).should be_valid
    build(:player_game, player: messi, game: game).should_not be_valid
  end

end
