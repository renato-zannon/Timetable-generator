class Group < ActiveRecord::Base
  belongs_to  :discipline
  attr_accessor :lessons
  
  validates :name,       :presence => true
  validates :discipline, :presence => true
  validates :lessons,    :presence => true
  
end
