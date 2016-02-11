class Contact < ActiveRecord::Base
  
  attr_accessible :firstname, :lastname, :address, :zip, :city, :country

    acts_as_gmappable 

    def gmaps4rails_address
        "#{self.address}, #{self.zip} #{self.city}, #{self.country}"
    end

end
