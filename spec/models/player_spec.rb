require "spec_helper"

describe "Player" do

  it "has a valid factory" do
    create(:player).should be_valid
  end

  it "is invalid without a name" do
    build(:player, name: nil).should_not be_valid
  end

  it "is invalid with a blank name" do
    build(:player, name: '').should_not be_valid
  end

  it "is invalid without a surname" do
    build(:player, surname: nil).should_not be_valid
  end

  it "is invalid without an email" do
    build(:player, email: nil).should_not be_valid
  end

  it "is invalid without unique email address" do
    create(:player, email: 'unique@example.com')
    build(:player, email: 'unique@example.com').should_not be_valid
  end

end