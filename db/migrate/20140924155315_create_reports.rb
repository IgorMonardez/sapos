class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :title
      t.text :description
      t.references :query

      t.timestamps
    end
    add_index :reports, :query_id
  end
end
