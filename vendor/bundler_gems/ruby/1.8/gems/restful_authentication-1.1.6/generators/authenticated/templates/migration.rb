class <%= migration_name %> < ActiveRecord::Migration
  def self.up
    create_table :<%= table_name %>, :force => true do |t|
      t.string :login, :crypted_password, :salt, :remember_token, :limit => 40
      t.datetime :remember_token_expires_at
      t.string :name,                      :limit => 100, :default => '', :null => true
      t.string :email,                     :limit => 100
<% if options[:include_activation] -%>
      t.string :activation_code,           :limit => 40
      t.datetime :activated_at
<% end -%>
<% if options[:stateful] -%>
      t.string :state,                     :null => :no, :default => 'passive'
      t.datetime :deleted_at
<% end -%>
      t.timestamps
    end
    add_index :<%= table_name %>, :login, :unique => true
  end

  def self.down
    drop_table :<%= table_name %>
  end
end
