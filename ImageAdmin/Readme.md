ImageAdmin
==========

Image management in ActiveAdmin

Admin Credentials:

    admin@example.com
    password


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
