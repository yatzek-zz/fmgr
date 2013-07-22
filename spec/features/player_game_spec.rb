require 'spec_helper'

feature 'PlayerGame' do

    scenario 'adds player game instance when user clicks the add link in the email' do
      messi = create :messi
      game = create :game
      link_hash = LinkUtils.url_encode(LinkUtils.create_link_hash(messi.id, game.id))

      expect { visit "#{LinkUtils::SUBSCRIBE_PATH}/#{link_hash}" }.to change(PlayerGame, :count).by(1)
      expect(page).to have_content(/leo\.messi\d@example\.com has been added!/)
    end

    scenario 'removes player game instance when user clicks the remove link in the email' do
      messi = create(:messi)
      game = create(:game)
      create(:player_game, player: messi, game: game)

      link_hash = LinkUtils.url_encode(LinkUtils.create_link_hash(messi.id, game.id))

      expect { visit "#{LinkUtils::UNSUBSCRIBE_PATH}/#{link_hash}" }.to change(PlayerGame, :count).by(-1)
      expect(page).to have_content(/leo\.messi\d@example\.com has been removed!/)
    end

end
