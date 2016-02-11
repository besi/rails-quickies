This application consists of a contact list which will be shown on a map.

Initial CRUD App
----------------

Shell commands (You may execute the whole script in one go):
             
	echo Create new rails structure
	rails new Gmaps4Rails	
	cd Gmaps4Rails
	
	pause Create scaffold for the people model and migrate the database
	rails g scaffold contact firstname:string lastname:string address:string zip:string city:string country:string
	rake db:migrate
	
	open http://localhost:3000/contacts
	say Please reload your web browser in a few moments &
	rails server
	echo Done :-)                                        
	
	
Adding gmaps4rails specific things
----------------------------------

Shell commands

	# Add the the gem to the Gemfile and use the bundle command to install it
	echo "gem 'gmaps4rails'" >> Gemfile                                        
	bundle install                                                         

	# Run the provided gmaps4rails generator
	rails generate gmaps4rails:install
   

Migrate the contact model to have the required parameters
                   
	rails g migration AddLongLatToContacts latitude:float longitude:float gmaps:boolean
    rake db:migrate

Change the model `contact.rb` to this:

	class Contact < ActiveRecord::Base

        attr_accessible :firstname, :lastname, :address, :zip, :city, :country

		acts_as_gmappable 

		def gmaps4rails_address
			"#{self.address}, #{self.zip} #{self.city}, #{self.country}"
		end
	
	end	  
	
Change the **body** part of your layout as follows

	<body>
	<%= yield :head %>
	<%= yield %>
	<%= yield :scripts %>
	</body>
		

Add a new action to your `contacts_controller.rb`:

	def map
	   @json = Contact.all.to_gmaps4rails
	end
	
Add a new file `map.html.erb` to the contact's view directory and add the following line to it:

	<%= gmaps4rails(@json) %>
	
Now we create a new custom route to our `routes.rb` by adding the following line:

 	match 'map' => "contacts#map"

Now we need to add a few [contacts](http://localhost:3000/contacts) which then magically appear on our [map](http://localhost:3000/map). 
	           
Links
-----

- Gem [Google-Maps-for-Rails](https://github.com/apneadiving/Google-Maps-for-Rails) on Github