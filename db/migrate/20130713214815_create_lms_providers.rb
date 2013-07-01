class CreateLmsProviders < ActiveRecord::Migration
  def change
    create_table :lms_providers do |t|
      t.string :name

      t.timestamps
    end
  end
end
