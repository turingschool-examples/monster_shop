require 'rails_helper'

RSpec.describe 'Admin User Index Page' do
  describe "As an Admin" do
    before :each do
      @larry = User.create(name: "Larry Green", address: "345 Blue Lane", city: "Blue City", state: "CA", zip: 56789, email: "green@gmail.com", password: "frogs", role: "admin")
      @user = User.create(name: "User", address: "123 Clarkson St", city: "Denver", state: "CO", zip: 80209, email: "user@gmail.com", password: "cheetos", role: "user")
      @employee = User.create(name: "Merchant", address: "456 Market St", city: "Denver", state: "CO", zip: 80210, email: "employee@gmail.com", password: "taco_sauce", role: "employee")
      @merchant = User.create(name: "Merchant", address: "456 Market St", city: "Denver", state: "CO", zip: 80210, email: "merchant@gmail.com", password: "taco_sauce", role: "merchant")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@larry)
    end

    it "when I visit the user index page I see all users in the system" do
      visit root_path

      within "nav" do
        click_on 'Users'
      end

      expect(current_path).to eq(admin_user_index_path)

      within "#user-#{@user.id}" do
        expect(page).to have_link(@user.name, href: admin_user_show_path(@user.id))
        expect(page).to have_content(@user.created_at)
        expect(page).to have_content(@user.role)
      end
    end

  end
end
# As an admin user
# When I click the "Users" link in the nav (only visible to admins)
# Then my current URI route is "/admin/users"
# Only admin users can reach this path.
# I see all users in the system
# Each user's name is a link to a show page for that user ("/admin/users/5")
# Next to each user's name is the date they registered
# Next to each user's name I see what type of user they are
