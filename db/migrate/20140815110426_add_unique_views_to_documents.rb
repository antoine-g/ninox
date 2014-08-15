class AddUniqueViewsToDocuments < ActiveRecord::Migration
  def change
    change_table :documents do |t|
      t.integer :unique_views, :default => 0
    end
  end
end
