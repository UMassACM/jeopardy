class Round < ActiveRecord::Base
  belongs_to :game
  has_many :categories
  
  def create
	super
	
	6.times { self.categories.build.save }
  end
  
  def save
	super
	self.categories.each {|item| item.save}
  end
end
