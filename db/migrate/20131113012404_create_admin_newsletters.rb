
# MindsMesh, Inc. (c) 2012-2013

# rails g scaffold admin/Newsletter title:string plainemail:text htmlemail:text status:boolean

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

