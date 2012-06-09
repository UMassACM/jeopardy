class Category < ActiveRecord::Base
  belongs_to :round
  has_many :questions
  
  #validates :name, :presence => true
  
  def create
	super
	5.times { self.questions.build.save }
  end
  
  def save
	super
	self.questions.each {|item| item.save}
  end
end
