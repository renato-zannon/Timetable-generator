class AddDisciplineToGroups < ActiveRecord::Migration
  def self.up
    change_table :groups do |t|
      t.references :discipline
    end
  end

  def self.down
    remove_column :groups, :discipline
  end
end
