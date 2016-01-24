class GameController < ApplicationController

  before_action :authenticate!

  def index
    @games = Game.all_by_date
  end
end
