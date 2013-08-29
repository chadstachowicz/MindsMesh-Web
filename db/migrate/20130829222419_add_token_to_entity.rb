class AddTokenToEntity < ActiveRecord::Migration
  def change
      add_column :entities, :token, :string
  end
end
