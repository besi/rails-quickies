ActiveAdmin.register Product do

  permit_params :id, :title, :price, :description, :created_at, :updated_at

end
