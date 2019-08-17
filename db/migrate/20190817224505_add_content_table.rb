class AddContentTable < ActiveRecord::Migration[6.0]
  def change
    create_table :content do |t|
      t.string   :title
      t.string   :author
      t.string   :state
      t.string   :thumbnail
      t.string   :summary
      t.string   :url
      t.string   :media_type
      t.string   :external_source
      t.string   :external_id
      t.datetime :consumed_at
      t.timestamps
    end
  end
end
