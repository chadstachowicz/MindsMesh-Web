class CreateAdminNewsletters < ActiveRecord::Migration
  def change
    create_table :admin_newsletters do |t|
      t.string :title
      t.text :plainemail
      t.text :htmlemail
      t.boolean :status

      t.timestamps
    end
  end
end
