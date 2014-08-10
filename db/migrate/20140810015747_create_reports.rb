class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.binary :image
      t.string :description
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
