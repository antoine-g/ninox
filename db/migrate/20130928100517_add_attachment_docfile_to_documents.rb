class AddAttachmentDocfileToDocuments < ActiveRecord::Migration
  def self.up
    change_table :documents do |t|
      t.attachment :docfile
    end
  end

  def self.down
    drop_attached_file :documents, :docfile
  end
end
