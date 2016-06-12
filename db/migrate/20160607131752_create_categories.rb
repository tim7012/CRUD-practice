class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :position
      t.timestamps
    end

    add_column :events, :category_id, :integer
    add_column :events, :category_id, :start_on
    add_column :events, :category_id, :schedule_at
    add_index :events, :category_id
  end
end
