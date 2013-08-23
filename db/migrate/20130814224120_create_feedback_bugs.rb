class CreateFeedbackBugs < ActiveRecord::Migration
  def change
    create_table :feedback_bugs do |t|
      t.integer :user_id
      t.string :type
      t.text :feedback

      t.timestamps
    end
  end
end
