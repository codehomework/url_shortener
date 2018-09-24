class IndexUrlShortPath < ActiveRecord::Migration[5.2]
  def change
    add_index :urls, :short_path
  end
end
