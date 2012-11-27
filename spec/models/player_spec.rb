require "rspec"
require "spec_helper"

describe "Player" do

  it "has a valid factory" do
    FactoryGirl.create(:player).should be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:player, name: nil).should_not be_valid
  end

  it "is invalid with a blank name" do
    FactoryGirl.build(:player, name: '').should_not be_valid
  end

  it "is invalid without a surname" do
    FactoryGirl.build(:player, surname: nil).should_not be_valid
  end

  it "is invalid without an email" do
    FactoryGirl.build(:player, email: nil).should_not be_valid
  end

  it "is invalid without unique email address" do
    FactoryGirl.create(:player, email: 'unique@example.com')
    FactoryGirl.build(:player, email: 'unique@example.com').should_not be_valid
  end

end