require 'spec_helper'
require "timecop"

describe GameDefinition do

  it "has a valid factory" do
    create(:game_definition).should be_valid
  end

  it "is invalid without a day" do
    build(:game_definition, day: nil).should_not be_valid
  end

  it "is invalid without a time" do
    build(:game_definition, time: nil).should_not be_valid
  end

  it "is unique for date and time" do
    create(:game_definition)
    build(:game_definition).should_not be_valid
  end

  describe "has periodic job which:" do

    before :each do
      @tue_12_00_game = create :game_definition
    end

    TIME_10_01_2013_11_00 = Time.local(2013, 1, 10, 11, 0, 0)
    TIME_10_01_2013_13_00 = Time.local(2013, 1, 10, 13, 0, 0)
    TIME_17_01_2013_13_00 = Time.local(2013, 1, 17, 13, 0, 0)

    it "does not create next game instance if not withing creation period" do
      Timecop.freeze TIME_10_01_2013_11_00 # more than 5 days before the game, next game: 15.01.2013 12:00
      GameDefinition.create_game_instances

      GameInstance.all.should be_empty
    end

    it "creates next game instance if within creation period and none exists" do
      Timecop.freeze TIME_10_01_2013_13_00 # less than 5 days before the game, next game: 15.01.2013 12:00
      GameDefinition.create_game_instances

      GameInstance.all.size.should == 1
      game_instance = GameInstance.first
      game_instance.game_definition.should == @tue_12_00_game
      game_instance.time.should == @tue_12_00_game.next_game_time
    end

    it "does not create next game instance if within creation period and game instance exists" do
      Timecop.freeze TIME_10_01_2013_13_00 # less than 5 days before the game, next game: 15.01.2013 12:00
      create(:game_instance, game_definition: @tue_12_00_game, time: @tue_12_00_game.next_game_time)

      GameInstance.all.size.should == 1

      GameDefinition.create_game_instances

      GameInstance.all.size.should == 1
    end


    it "creates next game instance if within creation period and past week game instance exists" do
      Timecop.freeze TIME_10_01_2013_13_00 # less than 5 days before the game, next game: 15.01.2013 12:00
      first_game_time = @tue_12_00_game.next_game_time
      create(:game_instance, game_definition: @tue_12_00_game, time: first_game_time)

      GameInstance.all.size.should == 1
      Timecop.freeze TIME_17_01_2013_13_00 # move one week forward

      GameDefinition.create_game_instances

      game_instances = GameInstance.all
      game_instances.size.should == 2
      game_instances.each { |g_i| g_i.game_definition.should == @tue_12_00_game }

      GameInstance.first.time.should == first_game_time
      GameInstance.last.time.should == @tue_12_00_game.next_game_time
    end


  end

end
