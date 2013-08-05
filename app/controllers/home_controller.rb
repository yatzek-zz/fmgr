require_relative 'application_controller'

class HomeController < ApplicationController

  def index
    @games_to_play = Game.future_by_date
  end

end
