feature 'Home page' do

    scenario 'visit root url - no game yet' do
      visit root_url
      expect(page).to have_content 'No games scheduled yet'
    end

    scenario 'visit root url - next game found' do
      time_29_01_2013_09_00 = Time.local(2013, 1, 29, 9, 0, 0)
      time_29_01_2013_12_00 = Time.local(2013, 1, 29, 12, 0, 0)

      Timecop.freeze time_29_01_2013_09_00

      @game = create(:game, time: time_29_01_2013_12_00)

      visit root_url

      expect(page).to have_content 'Next game on Tuesday 29 Jan 2013 at 12:00'
      expect(page).to have_content 'Players'
      Timecop.return
    end

end
