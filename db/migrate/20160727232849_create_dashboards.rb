class CreateDashboards < ActiveRecord::Migration[5.0]
  def change
    create_table :dashboards do |t|
      t.references  :agency, :null => false
      t.text        :name, :null => false
      t.text        :notes, :null => true
      t.boolean     :display_hero, :default => true
      t.boolean     :display_kpis, :default => true
      t.timestamps
    end
  end
end
