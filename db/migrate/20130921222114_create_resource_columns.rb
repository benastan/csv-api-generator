class CreateResourceColumns < ActiveRecord::Migration
  def change
    create_table :resource_columns do |t|
      t.integer :resource_id
      t.integer :index
      t.string :name
      t.integer :data_type

      t.timestamps
    end
  end
end
