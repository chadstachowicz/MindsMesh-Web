
# MindsMesh (c) 2013

class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :name
      t.string :slug
      t.boolean :self_joining, default: false

      t.timestamps
    end
  end
end
