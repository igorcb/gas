class CreateLaunches < ActiveRecord::Migration
  def change
    create_table :launches do |t|
      t.date :date_launche
      t.string :miles
      t.decimal :price
      t.decimal :total

      t.timestamps
    end
  end
end
