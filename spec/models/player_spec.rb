require "rspec"
require "spec_helper"

describe "Player" do

  it "has a valid factory" do
    FactoryGirl.create(:player).should be_valid
  end

  it "is invalid without a name"
  it "is invalid without a surname"
  it "is invalid without an email"

end