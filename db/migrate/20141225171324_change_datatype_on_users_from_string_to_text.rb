class ChangeDatatypeOnUsersFromStringToText < ActiveRecord::Migration
  def up
    change_column :users, :name, :text, :limit => nil
    change_column :users, :company, :text, :limit => nil
    change_column :users, :description, :text, :limit => nil
    change_column :users, :url, :text, :limit => nil
  end

  def down
    change_column :users, :name, :string
    change_column :users, :company, :string
    change_column :users, :description, :string
    change_column :users, :url, :string
  end
end
