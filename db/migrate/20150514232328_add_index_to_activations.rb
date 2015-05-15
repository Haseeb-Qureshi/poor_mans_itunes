class AddIndexToActivations < ActiveRecord::Migration
  def change
    add_index :users, :activation_token
  end
end
