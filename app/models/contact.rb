class Contact < ActiveRecord::Base
	validates_format_of :email, :with => /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/
	validates_numericality_of :phone, :only_integer => true, :message => "can only be whole number."
end
