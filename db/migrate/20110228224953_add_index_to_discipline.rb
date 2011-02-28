class AddIndexToDiscipline < ActiveRecord::Migration
  def self.up
    add_index :disciplines, :code, :unique => true
  end

  def self.down
    remove_index :disciplines, :code
  end
end
