class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :user, null: false, index: true
      t.references :track, null: false, index: true
      t.text :note, null: false

      t.timestamps null: false
    end
  end
end
