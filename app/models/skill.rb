class Skill < ActiveRecord::Base
	# Associate skills to users
	belongs_to :user

	# Capitalize skill before saving it
	before_save do
		self.name = self.name.capitalize
	end

	# Validate skill name
	validates(:name, presence: true)
end
