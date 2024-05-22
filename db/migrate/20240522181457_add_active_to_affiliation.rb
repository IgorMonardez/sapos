class AddActiveToAffiliation < ActiveRecord::Migration[7.0]
  def up
    add_column :affiliations, :active, :boolean
  end
  def down
    remove_column :affiliations, :active
  end
end
