class RelationDocumentsCourse < ActiveRecord::Migration
  def change
    change_table :documents do |t|
      t.references :course
    end
  end
end
