# This file includes tests for access restriction. 
# The Ability model (from CanCanCan gem) is used to define abilities of users based on their roles. 
# So, this tester basically tests the access restriction of users to any route and resource they may try to access.

require "cancan/matchers"
require 'rails_helper'

describe Ability do
	# First, load the seed.rb file in order to initialize default roles
	Rails.application.load_seed

	context "when is an admin" do
		before :all do
			@user = create_user # Only valid data
			@user.add_role(:admin)
			@ability = Ability.new(@user)
		end
		after :all do
			@user.destroy
		end

		it "should be a valid user" do
			expect(@user).to be_valid
		end

		it "should be able to manage any project" do
			expect(@ability).to be_able_to(:manage, Project)
		end
	end

	context "when is a common user" do
		before :all do
			@user = create_user # Only valid data
			@ability = Ability.new(@user)
		end
		after :all do
			@user.destroy
		end

		it "should be a valid user" do
			expect(@user).to be_valid
		end

		it "should be able to manage projects they are owner" do
			project = create_project
			@user.own_projects << project
			expect(@ability).to be_able_to(:manage, project)
		end

		it "should be able to create projects" do
			expect(@ability).to be_able_to(:create, Project)
		end

		it "should be able to read projects" do
			expect(@ability).to be_able_to(:read, create_project)
		end

		it "should not be able to edit, destroy or update any project they are not owner" do
			expect(@ability).not_to be_able_to([:edit, :destroy, :update], create_project)
		end
	end

	context "when is guest user (not logged in)" do
		before :all do
			@user = User.new # guest user (not logged in)
			@ability = Ability.new(@user)
		end

		it "should be able to read projects" do
			expect(@ability).to be_able_to(:read, create_project)
		end

		it "should not be able to create projects" do
			expect(@ability).not_to be_able_to(:create, Project)
		end

		it "should not be able to edit, destroy or update any project" do
			expect(@ability).not_to be_able_to([:edit, :destroy, :update], create_project)
		end
	end
end
