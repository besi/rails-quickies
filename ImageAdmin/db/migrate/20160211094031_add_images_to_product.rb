class AddImagesToProduct < ActiveRecord::Migration
  def change
    add_column :products, :images, :text
  end
end
