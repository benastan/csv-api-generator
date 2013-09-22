class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.integer :service_id
      t.string :name
      t.attachment :csv

      t.timestamps
    end
  end
end
