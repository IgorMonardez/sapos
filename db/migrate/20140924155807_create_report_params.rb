class CreateReportParams < ActiveRecord::Migration
  def change
    create_table :report_params do |t|
      t.references :report
      t.references :query_param
      t.string :value
      t.boolean :editable
      t.boolean :active

      t.timestamps
    end
    add_index :report_params, :report_id
    add_index :report_params, :query_param_id
  end
end
