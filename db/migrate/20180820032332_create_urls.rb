class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.text :long_url, limit: 20000
      t.string :short_path, limit: 8
      t.timestamps
    end
  end
end
