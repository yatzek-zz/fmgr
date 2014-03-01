require_relative 'application_controller'

class HomeController < ApplicationController

  def index
    @games_to_play = Game.in_the_future_by_date
  end

end
