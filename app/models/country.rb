class Country < ActiveRecord::Base

	has_many :users, :dependent => :nullify

	def self.options_for_select
		order('LOWER(name)').map { |e| [e.name, e.id] }
	end

end