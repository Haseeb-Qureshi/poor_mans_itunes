class AddActivationTokensAndAdmins < ActiveRecord::Migration
  def change
    add_column :users, :activation_token, :string, null: false, default: "pre-activated"
    add_column :users, :admin, :boolean, null: false, default: false
    add_index :albums, :band_id
  end
end
