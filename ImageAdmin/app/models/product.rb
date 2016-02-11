class Product < ActiveRecord::Base

  serialize :images, Array

  mount_uploaders :images, ImageUploader

  validates_presence_of :title

end
