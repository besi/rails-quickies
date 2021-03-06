ActiveAdmin.register Product do

  permit_params :title, :price, :description, :images_cache, images: []

  index do
    column do |p|

      link_to admin_product_path(p) do
        image_tag p.images.first.url(:thumb) rescue nil
      end
    end

    selectable_column
    id_column
    column :title
    column :price
    column(:description) { |p| truncate(p.description, length: 50) }

    actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :price
      f.input :description
      f.input :images, as: :file, input_html: {multiple: true}

      # TODO: The `images_cache` does not seem to work when unsing `serialize :images, Array` in the model
      f.input :images_cache, as: :hidden
    end
    f.actions
  end

  show do
    panel "Product details" do
      attributes_table_for resource do
        row :id
        row :title
        row :price
        row :description
        row :created_at
        row :updated_at
      end
    end
  end

  sidebar 'Images', only: [:show, :edit] do
    resource.images.each do |image|
      a href: image.url, target: '_blank' do
        img src: image.url, width: '100%'
      end
    end
  end

end
