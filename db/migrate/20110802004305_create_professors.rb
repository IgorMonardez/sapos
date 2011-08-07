class CreateProfessors < ActiveRecord::Migration
  def self.up
    create_table :professors do |t|
      t.string :name
      t.string :cpf
      t.date :birthdate

      t.timestamps
    end
  end

  def self.down
    drop_table :professors
  end
end