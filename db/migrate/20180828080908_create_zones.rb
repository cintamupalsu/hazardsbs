class CreateZones < ActiveRecord::Migration[5.1]
  def change
    create_table :zones do |t|
      t.string :place
      t.float :lat
      t.float :lon

      t.timestamps
    end
  end
end
