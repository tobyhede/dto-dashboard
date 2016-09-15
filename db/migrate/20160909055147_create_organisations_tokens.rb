class CreateOrganisationsTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :organisations_tokens do |t|
      t.references :organisation, :null => false, :index => true
      t.references :token, :null => false, :index => true
    end
  end
end
