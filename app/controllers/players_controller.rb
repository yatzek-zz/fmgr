require_relative "application_controller"

class PlayersController < ApplicationController

  before_action :authenticate!

  # GET /players
  # GET /players.json
  def index
    #@players = Player.sorted

    respond_to do |format|
      format.html # index.html.slim
      format.json do

        json = Player.for_data_table(self, %w(name surname email), %w(name surname email)) do |player|
          [player.name, player.surname, player.email,
           "<%= link_to('Show', player) %>", "<%= link_to('Edit', edit_player_path(player)) %>"]
        end

        render json: json
      end
    end
  end

  # GET /players/1
  # GET /players/1.json
  def show
    @player = Player.find(params[:id])

    respond_to do |format|
      format.html # show.html.slim
      format.json { render json: @player }
    end
  end

  # GET /players/new
  # GET /players/new.json
  def new
    @player = Player.new

    respond_to do |format|
      format.html # new.html.slim
      format.json { render json: @player }
    end
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render json: @player, status: :created, location: @player }
      else
        format.html { render "new" }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /players/1
  # PUT /players/1.json
  def update
    @player = Player.find(params[:id])

    respond_to do |format|
      if @player.update_attributes(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render 'edit' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    respond_to do |format|
      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :surname, :email)
  end

end
