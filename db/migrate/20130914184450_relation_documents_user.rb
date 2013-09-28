class RelationDocumentsUser < ActiveRecord::Migration
  def change
    change_table :documents do |t|
      t.references :user
    end
  end
end
