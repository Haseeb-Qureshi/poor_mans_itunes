class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :title, null: false, index: true
      t.boolean :bonus, default: false
      t.text :lyrics
      t.references :album, null: false

      t.timestamps null: false
    end
  end
end
