require 'spec_helper'

feature 'ContactUsController' do

  scenario 'renders Contact Us form' do
    visit contact_us_path
    page.should have_content 'Name'
    page.should have_content 'Email'
    page.should have_content 'Body'
    page.should have_button 'Submit'
  end

  scenario 'redirects to the root path when submitted successfully' do
    visit contact_us_path
    fill_in 'Name', :with => 'John Rambo'
    fill_in 'Email', :with => 'rambo@rambo.com'
    fill_in 'Body', :with => 'My machine gun is broken :{'
    click_button 'Submit'
    current_path.should == root_path
  end

  scenario 'shows validation errors when invalid' do
    visit contact_us_path
    click_button 'Submit'
    current_path.should == send_mail_path
    page.should have_content 'Sorry cowboy, check the fields below!'
  end

end
