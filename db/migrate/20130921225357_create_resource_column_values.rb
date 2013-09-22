class CreateResourceColumnValues < ActiveRecord::Migration
  def change
    create_table :resource_column_values do |t|
      t.integer :resource_column_id
      t.integer :index
      t.string :value

      t.timestamps
    end
  end
end
