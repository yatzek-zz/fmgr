require 'spec_helper'

feature "PlayerGame" do

    scenario "visit root url" do
      visit root_url
      #save_and_open_page
      page.should have_content "Tuesday Football"
    end

    scenario "adds player game instance when user clicks the add link in the email"
    scenario "removes player game instance when user clicks the remove link in the email"

    context "shows error message when link is invalid" do
      scenario "link is corrupted and cannot be decrypted"
      scenario "game instance cannot be found"
      scenario "player cannot be found"
    end

    # spec/features/widget_management_spec.rb
    #feature "widget management" do
    #  scenario "creating a new widget" do
    #    visit root_url
    #    click_link "New Widget"
    #
    #    fill_in "Name", with: "Awesome Widget"
    #    click_button "Create Widget"
    #
    #    expect(page).to have_text("Widget was successfully created.")
    #  end
    #end

end
