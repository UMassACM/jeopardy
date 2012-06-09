class ViewController < ApplicationController
	def index
	
	end
	def list
		@game = Game.find(params[:id])
	end
	def delete
		@game = Game.find(params[:id])
		@game.destroy
		redirect_to(:back)
	end
end
