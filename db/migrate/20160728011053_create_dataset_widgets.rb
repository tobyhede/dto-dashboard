class CreateDatasetWidgets < ActiveRecord::Migration[5.0]
  def change
    create_table :dataset_widgets do |t|
      t.references :dataset, :null => false
      t.references :widget, :null => false
      t.timestamps
    end

    add_index :dataset_widgets, :dataset_id
    add_index :dataset_widgets, :widget_id  
  end
end
