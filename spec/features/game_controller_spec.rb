feature GameController do

  scenario 'visit root url - next game found' do

    time_22_01_2013_12_00 = Time.local(2013, 1, 22, 12, 0, 0)
    time_29_01_2013_12_00 = Time.local(2013, 1, 29, 12, 0, 0)

    messi = create(:messi)
    iniesta = create(:iniesta)

    game_definition = create(:game_definition)
    game_1 = create(:game, game_definition: game_definition, time: time_22_01_2013_12_00)
    game_2 = create(:game, game_definition: game_definition, time: time_29_01_2013_12_00)

    create(:player_game, player: messi, game: game_1)
    create(:player_game, player: iniesta, game: game_2)

    visit '/games'

    expect(page).to have_content 'Game on Tuesday 22 Jan 2013 at 12:00'
    expect(page).to have_content 'Leo Messi'

    expect(page).to have_content 'Game on Tuesday 29 Jan 2013 at 12:00'
    expect(page).to have_content 'Anders Iniesta'
  end

  scenario 'allows to remove players from games' do

    time_22_01_2013_12_00 = Time.local(2013, 1, 22, 12, 0, 0)

    szlachta = create(:szlachta)

    game_definition = create(:game_definition)
    game_1 = create(:game, game_definition: game_definition, time: time_22_01_2013_12_00)

    create(:player_game, player: szlachta, game: game_1)

    visit '/games'

    click_link('remove')
    expect(page).to have_content("Jacek Szlachta has been removed - game on #{game_1.time_formatted}")

  end

end
