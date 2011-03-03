class AddDefaultValueToIntsOnGroup < ActiveRecord::Migration

  DAYS = %w[monday tuesday wednesday thursday friday saturday]
  
  def self.up
    DAYS.each do |day|
      change_column(:groups, "int_#{day}", 'integer', :default => 0)
    end
  end

  def self.down
    DAYS.each do |day|
      change_column(:groups, "int_#{day}", 'integer')
    end
  end
end
