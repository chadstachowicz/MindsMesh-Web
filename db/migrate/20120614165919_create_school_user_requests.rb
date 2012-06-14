class CreateSchoolUserRequests < ActiveRecord::Migration
  def change
    create_table :school_user_requests do |t|
      t.belongs_to :school
      t.belongs_to :user
      t.string :email
      t.string :confirmation_token
      t.datetime :last_email_sent_at

      t.timestamps
    end
    add_index :school_user_requests, :school_id
    add_index :school_user_requests, :user_id
  end
end
