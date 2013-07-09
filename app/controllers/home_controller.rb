require_relative 'application_controller'

class HomeController < ApplicationController

  def index
    @game = Game.next.first
  end

end
