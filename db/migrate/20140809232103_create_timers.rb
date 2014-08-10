class CreateTimers < ActiveRecord::Migration
  def change
    create_table :timers do |t|
      t.datetime :expires_at
      t.string :user_id
      t.text :numbers

      t.timestamps
    end
  end
end
