class Discipline < ActiveRecord::Base
  
  TPI_REGEX = /^(\d{1,2})-(\d{1,2})-(\d{1,2})$/
  CODE_REGEX = /\A(BC|MC|NH|EN)(\d{4})\Z$/
  
  validates :tpi,  :format   => TPI_REGEX
  validates :code, :format   => CODE_REGEX
  validates :name, :presence => true
  def teoric_hours
    broken_tpi[0].to_i
  end
  
  def practical_hours
    broken_tpi[1].to_i
  end
  
  def individual_hours
    broken_tpi[2].to_i
  end
  
  private
  
  def broken_tpi
    @broken_tpi ||= tpi.scan(TPI_REGEX)[0]
  end
end
