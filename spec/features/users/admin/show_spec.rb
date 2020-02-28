require 'rails_helper'

RSpec.describe "Admin Index" do
  describe "As an admin" do
    before :each do
      @admin = User.create!(user_name: "andrew@gmail.com", password: "thinking123", role: 2, name: "Andrew", address: "333 Market St", city: "Denver", state: "CO", zip: 80012 )
      @nathan = User.create!(user_name: "nthomas", password: "123",  password_confirmation: "123", name: "Nathan Thomas", address: "123 Main St", city: "Gunbarrel", state: "Colorado", zip: 80301)
      @andrew = User.create!(user_name: "ajohnson", password: "123",  password_confirmation: "123", name: "Andrew Johnson", address: "123 Main St", city: "Lakewood", state: "Colorado", zip: 80401)
      @jori = User.create!(user_name: "jpeterson", password: "123",  password_confirmation: "123", name: "Jori Peterson", address: "123 Main St", city: "Westminster", state: "Colorado", zip: 80791)
      @will = User.create!(user_name: "wthompson", password: "123",  password_confirmation: "123", name: "Will Thompson", address: "123 Main St", city: "Longmont", state: "Colorado", zip: 80501)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end

    describe "When I click a name on the users page "do
      it  "it takes me to that users page, where I see all information except for Edit Profile, and Edit Password Buttons" do
      visit admin_users_path
      click_link "wthompson"
      expect(page).to have_content(@will.name)
      expect(page).to have_content(@will.user_name)
      expect(page).to have_content(@will.address)
      expect(page).to have_content(@will.city)
      expect(page).to have_content(@will.state)
      expect(page).to have_content(@will.zip)
      expect(page).to_not have_link("Edit Profile")
      expect(page).to_not have_link("Edit Password")
      end
    end
  end
end
