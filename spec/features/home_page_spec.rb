require 'spec_helper'
require 'timecop'

feature 'Home page' do

    scenario 'visit root url - no game yet' do
      visit root_url
      page.should have_content 'No games yet'
    end

    scenario 'visit root url - next game found' do
      time_29_01_2013_09_00 = Time.local(2013, 1, 29, 9, 0, 0)
      time_29_01_2013_12_00 = Time.local(2013, 1, 29, 12, 0, 0)

      Timecop.freeze time_29_01_2013_09_00

      @game = create(:game, time: time_29_01_2013_12_00)

      visit root_url

      page.should have_content 'Game on Tuesday 29-Jan-2013 12:00'
      page.should have_content 'Players'
      Timecop.return
    end

end
