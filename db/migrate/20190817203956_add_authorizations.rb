class AddAuthorizations < ActiveRecord::Migration[6.0]
  def change
    create_table :authorizations do |t|
      t.integer :user_id
      t.string  :provider
      t.string  :state
      t.string  :token
    end

    add_index :authorizations, [:user_id]
  end
end
