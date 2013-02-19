require 'test_helper'

class UserTest < ActiveSupport::TestCase
	test "a user should enter a first name" do 
		user = User.new
		assert !user.save
		assert !user.errors[:first_name].empty?
	end

	test "a user should enter a last name" do 
		user = User.new
		assert !user.save
		assert !user.errors[:last_name].empty?
	end

	test "a user should enter a profile name" do 
		user = User.new
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test "a user should have a unique profile name" do
		user = User.new
		user.profile_name = 'bobbyong'
		user.email = "bobby89@gmail.com"
		user.first_name = "Bobby"
		user.last_name = "Ong"
		user.password = "password"
		user.password_confirmation = "password"
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test "a user should have a profile name without spaces" do
		user = User.new(first_name: "Bobby", last_name: "Ong", email: "bobbyongce@gmail.com")
		user.password = user.password_confirmation = 'password'

		user.profile_name = "My Profile With Spaces"

		assert !user.save
		assert !user.errors[:profile_name].empty?
		assert user.errors[:profile_name].include?("must be formatted correctly.")
	end

	test "a user can have a correctly formatted profile name" do
		user = User.new(first_name: "Bobby", last_name: "Ong", email: "bobbyongce@gmail.com")
		user.password = user.password_confirmation = 'password'

		user.profile_name = "bobby_ong-01"
		assert user.valid?
	end
end
