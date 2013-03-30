require 'spec_helper'

feature "PlayerGame" do

    let(:helper){Object.new.extend PlayersHelper}

    scenario "adds player game instance when user clicks the add link in the email" do

      # /playergame/subscribe/VPkLfUJeuwr_XC0-JVyssA==
      messi = create :messi
      game = create :game
      link_hash = helper.url_safe_encode(helper.create_link_hash(messi.id, game.id))
      visit "/playergame/subscribe/#{link_hash}"
    end

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
