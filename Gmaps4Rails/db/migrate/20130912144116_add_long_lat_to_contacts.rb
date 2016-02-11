class AddLongLatToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :latitude, :float
    add_column :contacts, :longitude, :float
    add_column :contacts, :gmaps, :boolean
  end
end
