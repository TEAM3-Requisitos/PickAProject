class User < ActiveRecord::Base
    # Devise is a flexible authentication solution for Rails based on Warden
	# Include its default modules
	devise(:database_authenticatable, :registerable,
		   :rememberable, :trackable, :validatable)

	# Associate users to projects that they own
	has_many(:own_projects, foreign_key: 'owner_id', class_name: "Project")
    has_and_belongs_to_many(:tasks)
	
	# Associate users to skills
	has_many :skills, dependent: :destroy

	# Give it roles
	rolify

	# Callbacks
	# Include default role to an user after their registration
	after_create :default_role
	# User default parameters
	before_save :default_parameters

	# Attach a profile picture to an user
	# Paperclip gem sintax for upload image files.
	has_attached_file :profile_picture, :styles => {}, :default_url => "missing_profile_picture.jpg"
	validates_attachment_content_type :profile_picture, :content_type => /\Aimage\/.*\Z/

	# Validations
	# Personal information
	validates(:username, uniqueness: { case_sensitive: false })
	validate(:validate_username)
	validates(:phone, numericality: { only_integer: true }, allow_blank: true)
	validates(:sex, inclusion: { in: %w(Male Female), message: "\"%{value}\" is not a valid sex" }, allow_blank: true)
	
	# Virtual attribute for authenticating by either username or email
	# This is in addition to a real persisted field like 'username'
	def login=(login)
		@login = login
	end

	def login
		@login || self.username || self.email
	end

	# Overwrite Devise's find_for_database_authentication to login with username
	# It can cause some errors in the login when used with MySQL
	# Visit: github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
	def self.find_for_database_authentication(warden_conditions)
		conditions = warden_conditions.dup
		if login = conditions.delete(:login)
			where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
		else
			where(conditions.to_hash).first
		end
	end

	private 
		# Add a default role to an user at its creation
		def default_role
			self.roles << Role.find_by_name("user")
			self.save
		end

		# Pick a Project starting pontuation
		def default_parameters
			self.points = 0
			self.name = self.name.split.map(&:capitalize).join(' ') unless name.blank?
			self.country = self.country.split.map(&:capitalize).join(' ') unless country.blank?
			self.city = self.city.split.map(&:capitalize).join(' ') unless city.blank?
			self.work = self.work.split.map(&:capitalize).join(' ') unless work.blank?
			self.education = self.education.split.map(&:capitalize).join(' ') unless education.blank?
		end

		# Fix the conflict between username and email
		def validate_username
			if User.where(email: username).exists?
				errors.add(:username, :invalid)
			end
		end
end
