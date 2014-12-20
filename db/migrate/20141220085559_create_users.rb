class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :description
      t.string :url
      t.index  :name
      t.index  :description

      t.timestamps
    end
  end
end
