class EditController < ApplicationController
	def index
		
	end
	
	def modify
		@game = Game.find(params[:id])
	end
	
	def update
		@game = Game.find(params[:id])
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
		redirect_to "/view/index"
	end
	
	def delete
		@game = Game.find(params[:id])
		@game.destroy
		redirect_to(:back)
	end
	
	def delete_all
		Round.all.each do |r|
			r.delete
		end
		Game.all.each do |g|
			g.destroy
		end
		session[:return_to] = request.referer
		redirect_to session[:return_to]
		#redirect_to(:back)
	end
end
