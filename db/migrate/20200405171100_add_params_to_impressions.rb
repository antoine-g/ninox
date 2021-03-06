# See https://github.com/charlotte-ruby/impressionist/blob/master/UPGRADE_GUIDE.md

class AddParamsToImpressions < ActiveRecord::Migration
  def change
    add_column :impressions, :params, :text
    add_index :impressions, [:impressionable_type, :impressionable_id, :params], :name => "poly_params_request_index", :unique => false
  end
end
