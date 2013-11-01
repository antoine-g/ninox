class AddLoginFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :role, :varchar, default: 'user', null: false
    add_column :users, :last_login_at, :timestamp
    add_column :users, :login_count, :integer, default: 0, null: false
    add_column :users, :failed_login_count, :integer, default: 0, null: false

    execute "UPDATE users SET role='admin' WHERE admin;"
    remove_column :users, :admin
  end
end
