class Game < ActiveRecord::Base
	has_many :rounds
	
	validates :name, :presence => true
	
# Override create
	def create
		super
		
		#temporary
		self.rounds.build.save #round one
		self.rounds.build.save #round two
	end
end
