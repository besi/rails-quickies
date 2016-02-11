ImageAdmin
==========

Image management in ActiveAdmin

Admin Credentials:

    admin@example.com
    password

 
![screenshot](https://raw.githubusercontent.com/besi/rails-quickies/master/ImageAdmin/Screenshot.png)


Preparation
-----

    # Create a Rails App
    gem update rails
    rails new ImageAdmin
    cd ImageAdmin
    rm README.rdoc
    touch Readme.md

    # Create the product model
    bin/rails g model product title:string price:decimal description:text
    bin/rake db:migrate

    # Install ActiveAdmin
    echo "gem 'devise'" >> Gemfile
    echo "gem 'activeadmin', '~> 1.0.0.pre2'" >> Gemfile
    bundle install
    rails generate active_admin:install
    bin/rake db:migrate
    bin/rake db:seed
    ruby -pi -e "gsub(/Products/, 'Product')" app/admin/products.rb
    bin/rails g active_admin:resource products


 Point the root to the admin controller `routes.rb`
Point the root to the admin controller `routes.rb`

    root 'admin/products#index'

Add the `permit_params` to `products.rb` so that the product can be modified in the admin interface:

    permit_params :title, :price, :description

**Note**: To get the list of params the following can be executed inside `bin/rails console`:

    Product.new.attributes.keys.map(&:to_sym)
    => [:id, :title, :price, :description, :created_at, :updated_at]

Installing Carrierwave
----------------------

Please note that the master branch of the `carrierwave` gem is required to get the `mount_uploader`**s** functionality.

    echo "gem 'mini_magick'" >> Gemfile
    echo "gem 'carrierwave', github: 'carrierwaveuploader/carrierwave', branch: 'master'" >> Gemfile
    bundle install
    touch tmp/restart.txt
    echo "public/uploads" >> .gitignore

Now in `app/uploaders/image_uploader.rb` uncomment `include CarrierWave::MiniMagick` and add thumbnail functionality as well as the ability to scale the master images:

    version :thumb do
      process resize_to_fit: [100, 100]
    end

    process resize_to_fit: [640, 640]

In the `Product` model add the following line

    mount_uploaders :images, ImageUploader

Add the `images` property to the model:

    bin/rails g migration AddImagesToProducts images:text

Run the migration:

    bin/rake db:migrate

In our `product.rb` the `images` need to be marked as array:

    serialize :images, Array


**Note**: I had to run `bin/spring stop` at some point so that the `ImageUploader` would be loaded.

Updating the Admin interface
----------------------------

The `permit_parmas` has to be extended with `:images[]`. Please note that this has to be the last item.

The images field is of the type `:file` and the `multiple` is has to be set to `true`. By adding the `images_cache` as a hidden input we can achieve that images are uploaded even if model validations fail:

    f.input :images, as: :file, input_html: {multiple: true}
    f.input :images_cache, as: :hidden

The sidebar should display the images when displaying and editing a product.

    sidebar 'Images', only: [:show, :edit] do
        resource.images.each do |image|
          img src: image.url, width: '100%'
        end
    end
    
The first image of the product is also shown in the index view for the products:

    index do
      column do |p|
        image_tag p.images.first.url(:thumb) rescue nil
      end
      
      # ...
    end


**TODO**: The `images_cache` does not seem to work when unsing `serialize :images, Array` in the model
