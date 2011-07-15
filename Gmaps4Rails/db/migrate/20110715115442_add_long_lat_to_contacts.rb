class AddLongLatToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :latitude, :float
    add_column :contacts, :longitude, :float
    add_column :contacts, :gmaps, :boolean
  end

  def self.down
    remove_column :contacts, :gmaps
    remove_column :contacts, :longitude
    remove_column :contacts, :latitude
  end
end
