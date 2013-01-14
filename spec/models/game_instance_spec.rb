require 'spec_helper'

describe GameInstance do

  it "has a valid factory" do
    create(:game_instance).should be_valid
  end

  it "is invalid without a time" do
    build(:game_instance, time: nil).should_not be_valid
  end

  it "is invalid without a game_definition" do
    build(:game_instance, game_definition: nil).should_not be_valid
  end

  it "is unique for game_definition and time" do
    game_definition = create(:game_definition)
    time = game_definition.next_game_time

    create(:game_instance, game_definition: game_definition, time: time)
    build(:game_instance, game_definition: game_definition, time: time).should_not be_valid
  end

end
