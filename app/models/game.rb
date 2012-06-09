class Game < ActiveRecord::Base
	has_many :rounds
	
	validates :name, :presence => true
	
	# Override create
	def create
		super
		
		self.rounds.build.save #round one
		self.rounds.build.save #round two
	end
	
	# Override save
	def save
		super
		self.rounds.each {|item| item.save}
	end
end
