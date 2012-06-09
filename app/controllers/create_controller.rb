class CreateController < ApplicationController
	def index
		
	end
	def save
		@game = Game.create
		@game.name = params[:game_name]
		@game.save

		@game.final_prompt = params[:final_prompt]
		@game.final_response = params[:final_response]

		#Rounds
		for i in 0..1
			#Categories
			for j in 0..5
				@game.rounds[i].categories[j].name = params["round#{i}cat#{j}"]
				#Questions
				for k in 0..4
					@game.rounds[i].categories[j].questions[k].prompt = params["round#{i}cat#{j}prompt#{k}"]
					@game.rounds[i].categories[j].questions[k].response = params["round#{i}cat#{j}response#{k}"]
				end
			end
		end
		
		@game.save
		redirect_to "/"
	end
end
