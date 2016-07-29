class CreateDashboards < ActiveRecord::Migration[5.0]
  def change
    create_table :dashboards do |t|
      t.text :name, :null => false
      t.text :agency, :null => false
      t.text :notes, :null => true
      t.timestamps
    end
  end
end
