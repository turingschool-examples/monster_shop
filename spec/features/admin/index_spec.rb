# frozen_string_literal: true

require 'rails_helper'

describe 'User visits categories index page' do
  context 'as admin' do
    it 'allows admin to see all categories' do
      admin = User.create(email: 'penelope', password: 'boom', role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_categories_path
      expect(page).to have_content('Admin Categories')
    end
  end

  context 'as default user' do
    it 'does not allow default user to see admin categories index' do
      user = User.create(email: 'fern@gully.com', password: 'password', role: 0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_categories_path

      expect(page).to_not have_content('Admin Categories')
      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end
  end

  context 'as a merchant user' do
    it 'does not allow a merchant user to see admin categories index' do
      user = User.create(email: 'gijoe.icloud.com', password: 'combat', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_categories_path

      expect(page).to_not have_content('Admin Categories')
      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end
  end

  context 'as a visitor' do
    it 'does not allow default user to see admin categories index' do
      visit admin_categories_path

      expect(page).to_not have_content('Admin Categories')
      expect(page).to have_content("The page you were looking for doesn't exist.")
      expect(page.status_code).to eq(404)
    end
  end
end
