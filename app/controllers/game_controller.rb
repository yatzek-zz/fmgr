class GameController < ApplicationController
  def index
    @games = Game.all_by_date
  end
end
