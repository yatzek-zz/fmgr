require 'spec_helper'

feature "Player" do

    scenario "visit root url" do
      visit root_url
      #save_and_open_page
      page.should have_content "Sky Football"
      page.should have_link "link"
    end

end
