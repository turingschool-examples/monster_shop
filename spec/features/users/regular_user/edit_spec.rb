require 'rails_helper'

RSpec.describe "Edit User Profile" do
      before :each do

        @andrew = User.create!(user_name: "ajohnson", password: "123",  password_confirmation: "123", name: "Andrew Johnson", address: "123 Main St", city: "Lakewood", state: "Colorado", zip: 80401)
        @jori = User.create!(user_name: "jpeterson", password: "123",  password_confirmation: "123", name: "Jori Peterson", address: "123 Main St", city: "Westminster", state: "Colorado", zip: 80791)
        @will = User.create!(user_name: "wthompson", password: "123",  password_confirmation: "123", name: "Will Thompson", address: "123 Main St", city: "Longmont", state: "Colorado", zip: 80501)
        visit root_path
        click_link "Login"
        fill_in "User name", with: "wthompson"
        fill_in "Password", with: "123"
        click_button "Log In"
      end

      it "I can click a link to edit my profile data and am taken to a new form and the form is prepopulated" do

        click_link "Edit Profile"

        expect(find_field('Name').value).to eq 'Will Thompson'
        expect(find_field('User name').value).to eq 'wthompson'
        expect(find_field('Address').value).to eq '123 Main St'
        expect(find_field('City').value).to eq 'Longmont'
        expect(find_field('State').value).to eq 'Colorado'
        expect(find_field('Zip').value).to eq '80501'
        click_button "Update User"

      end

      it "I am returned to my profile page and I see a flash message telling me that my data is updated. I see my updated information" do


        click_link "Edit Profile"

        fill_in "Name", with: "John Smith"
        fill_in "User name", with: "jsmith"
        fill_in "Address", with: "456 North St"
        fill_in "City", with: "New York City"
        fill_in "State", with: "New York"
        fill_in "Zip", with: "00000"
        click_button "Update User"
        expect(current_path).to eq(profile_path)
        expect(page).to have_content("John Smith")
        expect(page).to have_content("456 North St")
        expect(page).to have_content("New York")
        expect(page).to have_content("00000")
        expect(page).to_not have_content("password")
        expect(page).to have_content("Your profile has been updated!")

      end

    describe "If I include an email address that is already in the system" do
      it "redirects to the form with a flash message saying the username is already taken" do
        click_link "Edit Profile"
        fill_in "User name", with: "ajohnson"
        click_button "Update User"

        expect(current_path).to eq(user_path(@will))
        expect(page).to have_content("User name has already been taken")
      end
      end

    describe "When I try to update my password and the passwords do not match" do
      it "tells me the password passwords dont and redirects me to the esit password_page" do
        click_link "Edit Password"
        fill_in "Password", with: "123"
        fill_in "Password confirmation", with: "12"
        click_button "Update User"
        expect(page).to have_content("Password confirmation doesn't match Password")
      end


        it "When I fill in the edit password field correctlyI am redirected to the profile page " do
          click_link "Edit Password"

        fill_in "Password", with: "123"
        fill_in "Password confirmation", with: "123"
        click_button "Update User"
        expect(current_path).to eq(profile_path)
        expect(page).to have_content("Your profile has been updated!")

      end
      end
    end
