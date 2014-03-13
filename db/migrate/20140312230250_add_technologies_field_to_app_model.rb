class AddTechnologiesFieldToAppModel < ActiveRecord::Migration
  def change
      add_column :apps, :technologies, :string
  end
end
