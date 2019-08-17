class AddUid < ActiveRecord::Migration[6.0]
  def change
    add_column :authorizations, :uid, :string
    add_column :authorizations, :key, :string
  end
end
