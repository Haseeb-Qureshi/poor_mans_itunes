class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name, null: false, index: true
      t.references :band, null: false
      t.boolean :live, default: false

      t.timestamps null: false
    end
  end
end
