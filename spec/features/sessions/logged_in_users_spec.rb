require 'rails_helper'

RSpec.describe "Login Specifics" do
	describe "As a regular user, if logged in" do
		it "I am redirected to my profile page if I visit /login" do

			user = User.create!(user_name: "jori@gmail.com", password: "testing123", role: 0, name: "Jori", address: "123 Market St", city: "Denver", state: "CO", zip: 80012 )

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

			visit login_path

			expect(current_path).to eq profile_path
			expect(page).to have_content("You are already logged in.")
		end
	end

  describe "As a user who works for a merchant, if logged in" do
		it "I am redirected to the my merchant dashboard if I visit /login" do

      megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      merchant_employee = User.create!(user_name: "nathan@gmail.com", password: "password123", role: 0, name: "Nathan", address: "123 Market St", city: "Denver", state: "CO", zip: 80012, merchant_id: megan.id )

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_employee)

			visit login_path

			expect(current_path).to eq merchant_dashboard_path
			expect(page).to have_content("You are already logged in.")
    end
	end

	describe "As a merchant_admin, if logged in" do
		it "I am redirected to the my merchant dashboard when I visit /login" do

      megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      merchant_admin = User.create!(user_name: "nathan@gmail.com", password: "password123", role: 1, name: "Nathan", address: "123 Market St", city: "Denver", state: "CO", zip: 80012, merchant_id: megan.id )

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_admin)

			visit login_path

			expect(current_path).to eq merchant_dashboard_path
			expect(page).to have_content("You are already logged in.")
    end
	end

	describe "As an admin, when logged in" do
		it "I am redirected to the admin dashboard if I visit /login" do

			admin = User.create!(user_name: "andrew@gmail.com", password: "thinking123", role: 2, name: "Andrew", address: "333 Market St", city: "Denver", state: "CO", zip: 80012 )

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

			visit login_path

			expect(current_path).to eq admin_dashboard_path
			expect(page).to have_content("You are already logged in.")
		end
	end
end
