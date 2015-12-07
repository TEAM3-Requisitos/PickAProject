class Task < ActiveRecord::Base
	# Associate tasks to users and projects
	# Each project and user has a list of tasks
	belongs_to(:project)
	belongs_to(:user)
    has_and_belongs_to_many(:requesters, class_name: "User")
    has_and_belongs_to_many(:contributors, class_name: "User")

	# Attach image to a project
	has_attached_file(:image_file, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png")

	# Check if the image file's name is valid
	validates_attachment_content_type(:image_file, :content_type => /\Aimage\/.*\Z/)

	# Impossible to create a task without a title
	validates(:title, presence:true)
	TITLE_MAX_LENGTH = 60 # Characters
	TITLE_MIN_LENGTH = 3  # Characters
	validates(:title, length: { in: TITLE_MIN_LENGTH...TITLE_MAX_LENGTH })

    # Impossible to set manually the status name, there
    # are limitted options to choose
    PERMITTED_STATUS = %w(Running Stopped Planning Finished)
    validates(:status, inclusion: PERMITTED_STATUS)
    # The default value for each task is Stopped
    after_initialize(:initialize_status)

	# Impossible to create a task without a difficult level
	validates(:difficult, presence: true)
	# Accept only integer numbers for difficult level
	validates(:difficult, numericality: { only_integer: true })
	# Impossible to set the task difficult out of the following
	# permitted fibonacci numbers.
	# This behavior was arbitrary selected.
	PERMITTED_FIBONACCI_VALUES = [1, 2, 3, 5, 8, 13, 21]
	validates_inclusion_of(:difficult, in: PERMITTED_FIBONACCI_VALUES)

	# Impossible to create a task without a description
	validates(:description, presence: true)
	DESCRIPTION_MAX_LENGTH = 10000 # Characters
	DESCRIPTION_MIN_LENGTH = 200 # Characters
	validates(:description, length: { in: DESCRIPTION_MIN_LENGTH...DESCRIPTION_MAX_LENGTH })

    private
      def initialize_status
        self.status ||= "Stopped"
      end
end
