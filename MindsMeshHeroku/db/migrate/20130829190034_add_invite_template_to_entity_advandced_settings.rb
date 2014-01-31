class AddInviteTemplateToEntityAdvandcedSettings < ActiveRecord::Migration
  def change
      add_column :entity_advanced_settings, :invite_template, :string
  end
end
