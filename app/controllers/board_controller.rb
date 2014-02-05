class BoardController < ApplicationController
	def index
		begin
			@game = Game.find(params[:id])
		rescue
			@game = Game.all[0] #for debugging without an id
		end
		
		@round = 0 #temporarily hard-coded at 0
		
	end
	
	def question
		@game = Game.find(params[:id])
		@round = params[:round].to_i
		@cat = params[:category].to_i
		@question = params[:amount].to_i
		
#		respond_to do |format|
#			format.json { render :json => @game.rounds[@round].categories[@cat].questions[@question] }
#		end
		respond_to do |format|
			#markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
			@temp = @game.rounds[@round].categories[@cat].questions[@question];
			@my_hash = { :prompt => markdown(@temp.prompt), :response => @temp.response }
			format.json { render :json => @my_hash }
			
			#format.json{ render :json => markdown(@game.rounds[@round].categories[@cat].questions[@question].prompt) }
		end
	end
	def markdown(text)
		markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true, :fenced_code_blocks => true, :lax_spacing => true)
		markdown.render(text).html_safe
	end
	
	def presenter
		
	end
	
	def prompt
		@game = Game.find(params[:id])
		
		@round = params[:round].to_i
		@category = params[:category].to_i
		@amount = params[:amount].to_i
		#@prompt_text = "This is the average velocity of an unlaiden swallow."
		@prompt_text = @game.rounds[@round].categories[@category].questions[@amount].prompt
	end
	
	def correct_response
		@game = Game.find(params[:id])
		
		@round = params[:round].to_i
		@category = params[:category].to_i
		@amount = params[:amount].to_i
		#@correct_text = "Would that be an African or a European swallow?"
		@correct_text = @game.rounds[@round].categories[@category].questions[@amount].response
	end
	
	def final_jeopardy
		@game = Game.find(params[:id])
		@prompt = @game.final_prompt
		@response = @game.final_response
	end
end
