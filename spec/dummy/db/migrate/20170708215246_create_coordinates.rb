class CreateCoordinates < ActiveRecord::Migration[5.1]
  def change
    create_table :coordinates do |t|
      t.string :lat
      t.string :lng

      t.timestamps
    end
  end
end
