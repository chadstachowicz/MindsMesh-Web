class CreateNotifies < ActiveRecord::Migration
  def change
    create_table :notifies do |t|
      t.string :target_type
      t.integer :target_id

      t.timestamps
    end
    add_index :notifies, [:target_type]
  end
end
