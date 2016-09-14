class CreateDatasetsTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :datasets_tokens do |t|
      t.references :dataset, :null => false, :index => true
      t.references :token, :null => false, :index => true
    end
  end
end
