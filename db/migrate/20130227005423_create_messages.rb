class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :receiver_id
      t.string :receiver_fb_id
      t.text :text
      t.integer :replies_count
      t.integer :expired
      t.datetime :expiration_date

      t.timestamps
    end
  end
end
