class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :name
      t.integer :int_monday
      t.integer :int_tuesday
      t.integer :int_wednesday
      t.integer :int_thursday
      t.integer :int_friday
      t.integer :int_saturday

      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
