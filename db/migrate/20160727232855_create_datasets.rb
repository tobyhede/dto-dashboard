class CreateDatasets < ActiveRecord::Migration[5.0]
  def change
    create_table :datasets do |t|
      t.references :agency, :null => false
      t.text       :name, :null => false
      t.timestamps
    end
  end
end
