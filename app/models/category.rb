class Category < ActiveRecord::Base
  belongs_to :round
  has_many :questions
  
  def create
	super
	
	self.questions.build.save
	self.questions.build.save
	self.questions.build.save
	
	self.questions.build.save
	self.questions.build.save
	self.questions.build.save
  end
end
