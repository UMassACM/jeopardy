class Round < ActiveRecord::Base
  belongs_to :game
  has_many :categories
  
  def create
	super
	
	self.categories.build.save
	self.categories.build.save
	self.categories.build.save
	self.categories.build.save
	self.categories.build.save
	self.categories.build.save
  end
end
