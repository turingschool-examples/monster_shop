require 'rails_helper'

RSpec.describe "Admin Index" do
  describe "As an admin" do
    before :each do
      @admin = User.create!(user_name: "andrew@gmail.com", password: "thinking123", role: 2, name: "Andrew", address: "333 Market St", city: "Denver", state: "CO", zip: 80012 )
      @nathan = User.create!(user_name: "nthomas", password: "123",  password_confirmation: "123", name: "Nathan Thomas", address: "123 Main St", city: "Gunbarrel", state: "Colorado", zip: 80301)
      @andrew = User.create!(user_name: "ajohnson", password: "123",  password_confirmation: "123", name: "Andrew Johnson", address: "123 Main St", city: "Lakewood", state: "Colorado", zip: 80401)
      @jori = User.create!(user_name: "jpeterson", password: "123",  password_confirmation: "123", name: "Jori Peterson", address: "123 Main St", city: "Westminster", state: "Colorado", zip: 80791)
      @will = User.create!(user_name: "wthomson", password: "123",  password_confirmation: "123", name: "Will Thompson", address: "123 Main St", city: "Longmont", state: "Colorado", zip: 80501)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end

    describe "When I click the Users link in the nav bar"do
    it  "I am taken to a user index page and see a full list of registered users and each users name is a link" do
      visit root_path
      click_link "All Users"
      expect(current_path).to eq(admin_users_path)
      expect(page).to have_link(@jori.user_name)
      expect(page).to have_content(@jori.created_at.to_formatted_s(:short))
      expect(page).to have_content(@jori.role)

      expect(page).to have_link(@nathan.user_name)
      expect(page).to have_content(@nathan.created_at.to_formatted_s(:short))
      expect(page).to have_content(@nathan.role)

      expect(page).to have_link(@andrew.user_name)
      expect(page).to have_content(@andrew.created_at.to_formatted_s(:short))
      expect(page).to have_content(@andrew.role)

      expect(page).to have_link(@will.user_name)
      expect(page).to have_content(@will.created_at.to_formatted_s(:short))
      expect(page).to have_content(@will.role)
    end
  end
end
end
