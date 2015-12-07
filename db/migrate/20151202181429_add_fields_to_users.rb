class AddFieldsToUsers < ActiveRecord::Migration
	def change
		# Pick a Project data
		add_column :users, :points, :integer

		# Personal information
		add_column :users, :username, :string
		add_column :users, :phone, :string
		add_column :users, :birthday, :datetime
		add_column :users, :sex, :string
		add_column :users, :country, :string
		add_column :users, :state, :string
		add_column :users, :city, :string

		# Professional information
		add_column :users, :work, :string
		add_column :users, :education, :string
		add_column :users, :skills, :string
	end
end
