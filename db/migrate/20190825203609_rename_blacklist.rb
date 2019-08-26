class RenameBlacklist < ActiveRecord::Migration[6.0]
  def change
    rename_table :jwt_blacklist, :jwt_blacklists
  end
end
