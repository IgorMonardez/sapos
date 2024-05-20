class CreateInstituitonProfessorJoinTable < ActiveRecord::Migration[7.0]
  def up
    create_join_table :institutions, :professors do |t|
      t.index :institutions_id
      t.index :professors_id
      t.datetime :data_inicio
      t.datetime :data_fim

      t.timestamps
    end

    remove_column :professors, :institution_id
  end

  def down
    drop_join_table :institutions, :professors
    add_column :professors, :institution_id, :integer
    add_index :professors, :institution_id
  end
end
