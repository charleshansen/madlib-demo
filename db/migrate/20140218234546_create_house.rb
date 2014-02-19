class CreateHouse < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.float :tax
      t.float :bedroom
      t.float :bath
      t.float :price
      t.float :size
      t.float :lot

      t.timestamps
    end
  end
end
