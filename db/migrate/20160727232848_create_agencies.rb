class CreateAgencies < ActiveRecord::Migration[5.0]
  def change
    create_table :agencies do |t|
      t.text       :name, :null => false
      t.text       :url, :null => false
      t.text       :description, :null => true
      t.timestamps
    end
  end
end
