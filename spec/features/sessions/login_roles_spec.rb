require 'rails_helper'

RSpec.describe "Login Specifics" do
	describe "As a regular user, when I log in" do
		it "I am redirected to my profile page" do

			user = User.create!(user_name: "jori@gmail.com", password: "testing123", role: 0, name: "Jori", address: "123 Market St", city: "Denver", state: "CO", zip: 80012 )

			visit login_path
			fill_in "User name", with: "jori@gmail.com"
			fill_in "Password", with: "testing123"
			click_button "Log In"

			expect(current_path).to eq profile_path
			expect(page).to have_content("Logged in as #{user.name}")
		end
	end

  describe "As a user who works for a merchant, when I log in" do
		it "I am redirected to the my merchant dashboard" do

      megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      merchant_employee = User.create!(user_name: "nathan@gmail.com", password: "password123", role: 0, name: "Nathan", address: "123 Market St", city: "Denver", state: "CO", zip: 80012, merchant_id: megan.id )

			visit login_path
			fill_in "User name", with: "nathan@gmail.com"
			fill_in "Password", with: "password123"
			click_button "Log In"

			expect(current_path).to eq merchant_dashboard_path
			expect(page).to have_content("Logged in as #{merchant_employee.name}")
    end
	end

	describe "As a merchant_admin, when I log in" do
		it "I am redirected to the my merchant dashboard" do

      megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      merchant_admin = User.create!(user_name: "nathan@gmail.com", password: "password123", role: 1, name: "Nathan", address: "123 Market St", city: "Denver", state: "CO", zip: 80012, merchant_id: megan.id )

			visit login_path
			fill_in "User name", with: "nathan@gmail.com"
			fill_in "Password", with: "password123"
			click_button "Log In"

			expect(current_path).to eq merchant_dashboard_path
			expect(page).to have_content("Logged in as #{merchant_admin.name}")
    end
	end

	describe "As an admin, when I log in" do
		it "I am redirected to the admin dashboard" do

			admin = User.create!(user_name: "andrew@gmail.com", password: "thinking123", role: 2, name: "Andrew", address: "333 Market St", city: "Denver", state: "CO", zip: 80012 )

			visit login_path
			fill_in "User name", with: "andrew@gmail.com"
			fill_in "Password", with: "thinking123"
			click_button "Log In"

			expect(current_path).to eq admin_dashboard_path
			expect(page).to have_content("Logged in as #{admin.name}")
		end
	end
end
