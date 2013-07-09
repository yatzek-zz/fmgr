require 'spec_helper'
require 'timecop'

feature 'Home page' do

    scenario 'visit root url - no game yet' do
      visit root_url
      page.should have_content 'No game yet'
    end

    scenario 'visit root url - next game found' do

      _TIME_29_01_2013_09_15 = Time.local(2013, 1, 29, 9, 15, 0)
      _TIME_29_01_2013_12_00 = Time.local(2013, 1, 29, 12, 0, 0)

      Timecop.freeze(_TIME_29_01_2013_09_15)
      @game = create(:game, time: _TIME_29_01_2013_12_00)

      visit root_url

      page.should have_content 'Next game on Tuesday 29-Jan-2013 12:00'
      page.should have_content 'Players'
    end

end
