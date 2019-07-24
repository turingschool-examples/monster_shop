require 'rails_helper'

RSpec.describe 'Admin' do
  describe "I visit a user's profile page ('/admin/users/5') and see the" do
      before :each do
        @larry = User.create(name: "Larry Green", address: "345 Blue Lane", city: "Blue City", state: "CA", zip: 56789, email: "green@gmail.com", password: "frogs", role: "admin")
        @user = User.create(name: "Tyler", address: "123 Clarkson St", city: "Denver", state: "CO", zip: 80209, email: "user@gmail.com", password: "cheetos", role: "user")
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@larry)
        visit admin_user_show_path(@user)
      end

      it "I see the same information the user would see themselves" do
        within("#user-#{@user.id}") do
          expect(page).to have_content("Name: #{@user.name}")
          expect(page).to have_content("Email: #{@user.email}")
          expect(page).to have_content("Address: #{@user.address}")
          expect(page).to have_content("City: #{@user.city}")
          expect(page).to have_content("State: #{@user.state}")
          expect(page).to have_content("Zip: #{@user.zip}")
        end
      end

      it "I see a link to edit their profile" do
        click_on 'Edit Profile'
        expect(current_path).to eq(admin_user_edit_path(@user.id))

        expect(page).to_not have_content("Password")
        fill_in "Name", with: "Roger Rabbit"
        select "Merchant", :from => "Role"

        click_on "Update Profile"

        expect(current_path).to eq(admin_user_show_path(@user))
        @user.reload
        expect(@user.name).to eq("Roger Rabbit")
        expect(@user.role).to eq("merchant")
      end
    end
  end
