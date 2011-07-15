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
	rails s
	echo Done :-)    
	           
Links
-----

- Gem [Google-Maps-for-Rails](https://github.com/apneadiving/Google-Maps-for-Rails) on Github