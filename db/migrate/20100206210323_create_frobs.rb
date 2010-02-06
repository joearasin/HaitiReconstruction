class CreateFrobs < ActiveRecord::Migration
  def self.up
    create_table :frobs do |t|
      t.string :token
      t.timestamps
    end
  end

  def self.down
    drop_table :frobs
  end
end
