class CreateInstitutionsProfessors < ActiveRecord::Migration[7.0]
  def up
    create_table :affiliation, id: false do |t|
      t.belongs_to :professors, :institutions, index: true, foreign_keys: true
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
    remove_column :professors, :institution_id
  end
  def down
    drop_table :affiliation
    add_column :professors, :institution_id, :integer
    add_index :professors, :institution_id
  end
end
