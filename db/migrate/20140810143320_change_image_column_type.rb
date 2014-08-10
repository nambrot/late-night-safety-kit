class ChangeImageColumnType < ActiveRecord::Migration
  def change
    change_column :reports, :image, :string
  end
end
