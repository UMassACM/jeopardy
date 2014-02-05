class ViewController < ApplicationController
	def index
	
	end
	
	def list
		@game = Game.find(params[:id])
	end
end
