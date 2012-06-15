class CreateSchoolUsers < ActiveRecord::Migration
  def change
    create_table :school_users do |t|
      t.belongs_to :school
      t.belongs_to :user
      t.boolean :b_student
      t.boolean :b_moderator
      t.boolean :b_teacher
      t.boolean :b_admin

      t.timestamps
    end
    add_index :school_users, :school_id
    add_index :school_users, :user_id
  end
end
