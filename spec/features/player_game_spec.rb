
feature 'PlayerGame' do

  context 'subscribe' do

    scenario 'adds player game instance when user clicks the add link in the email' do
      messi = create(:messi)
      game = create(:game, time: Time.now + 1.hour)
      link_hash = LinkUtils.url_encode(LinkUtils.create_link_hash(messi.id, game.id))

      expect { visit "#{LinkUtils::SUBSCRIBE_PATH}/#{link_hash}" }.to change(PlayerGame, :count).by(1)
      expect(page).to have_content(/leo\.messi\d*@example\.com has been added/)
      expect(page).not_to have_content('Wrong link? This game has already been played!')
    end

    scenario 'shows warning for games in the past' do
      messi = create(:messi)
      game = create(:game, time: Time.now - 1.hour)
      link_hash = LinkUtils.url_encode(LinkUtils.create_link_hash(messi.id, game.id))

      expect { visit "#{LinkUtils::SUBSCRIBE_PATH}/#{link_hash}" }.to change(PlayerGame, :count).by(1)
      expect(page).to have_content('Wrong link? This game has already been played!')
    end

  end

  #context 'unsubsribe' do
  #
  #  scenario 'removes player game instance when user clicks the remove link in the email' do
  #    messi = create(:messi)
  #    game = create(:game,  time: Time.now + 1.hour)
  #    create(:player_game, player: messi, game: game)
  #
  #    link_hash = LinkUtils.url_encode(LinkUtils.create_link_hash(messi.id, game.id))
  #
  #    expect { visit "#{LinkUtils::UNSUBSCRIBE_PATH}/#{link_hash}" }.to change(PlayerGame, :count).by(-1)
  #    expect(page).to have_content(/leo\.messi\d*@example\.com has been removed/)
  #    expect(page).not_to have_content('Wrong link? This game has already been played!')
  #  end
  #
  #  scenario 'shows warning for games in the past' do
  #    messi = create(:messi)
  #    game = create(:game,  time: Time.now - 1.hour)
  #    create(:player_game, player: messi, game: game)
  #
  #    link_hash = LinkUtils.url_encode(LinkUtils.create_link_hash(messi.id, game.id))
  #
  #    expect { visit "#{LinkUtils::UNSUBSCRIBE_PATH}/#{link_hash}" }.to change(PlayerGame, :count).by(-1)
  #    expect(page).to have_content('Wrong link? This game has already been played!')
  #  end
  #
  #end

end
