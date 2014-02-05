class TestController < ApplicationController
  def created
	@g = Game.create
	@g.name = params[:game_name]
	@g.save
	
	###
	@games = Game.all
  end
end
