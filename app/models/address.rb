class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :booking

  validates_presence_of :first_name, :last_name, :address, :zipcode, :city
end
