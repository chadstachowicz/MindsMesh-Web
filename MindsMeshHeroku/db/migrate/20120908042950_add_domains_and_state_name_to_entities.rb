
# MindsMesh (c) 2013

class AddDomainsAndStateNameToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :domains, :string
    add_column :entities, :state_name, :string
  end
end
