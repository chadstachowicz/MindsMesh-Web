class CreateSectionUsers < ActiveRecord::Migration
  def change
    create_table :section_users do |t|
      t.references :section
      t.references :user
      t.string :role

      t.timestamps
    end
    add_index :section_users, :section_id
    add_index :section_users, :user_id
  end
end
