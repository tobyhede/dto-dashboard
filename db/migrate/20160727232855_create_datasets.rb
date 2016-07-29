class CreateDatasets < ActiveRecord::Migration[5.0]
  def change
    create_table :datasets do |t|
      t.text :name, :null => false
      t.text :agency, :null => false      
      t.timestamps
    end
  end
end
