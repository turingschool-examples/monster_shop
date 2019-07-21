require 'rails_helper'

RSpec.describe 'Admin' do
  describe "I visit a user's profile page ('/admin/users/5') and see the" do
      before :each do
        @larry = User.create(name: "Larry Green", address: "345 Blue Lane", city: "Blue City", state: "CA", zip: 56789, email: "green@gmail.com", password: "frogs", role: "admin")
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@larry)
        visit admin_user_show_path(@larry)
      end

      it "I see the same information the user would see themselves" do
        within("#user-#{@user.id}-info") do
          expect(page).to have_content("Name: #{@user.name}")
          expect(page).to have_content("Email: #{@user.email}")
          expect(page).to have_content("Address: #{@user.address}")
          expect(page).to have_content("City: #{@user.city}")
          expect(page).to have_content("State: #{@user.state}")
          expect(page).to have_content("Zip: #{@user.zip}")
        end
      end

      it "I do not see a link to edit their profile" do
        expect(page). to not_have_content("Edit Profile")
      end
    end
  end
