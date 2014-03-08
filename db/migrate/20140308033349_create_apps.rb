class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :dataset_uris
      t.string :challenge_url
      t.string :codebase_url
      t.string :demo_url
      t.text :description
      t.string :name
      t.text :creators
      t.string :organization
      t.string :location
      t.string :logo_url
      t.boolean :visible

      t.timestamps
    end
  end
end
