require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit '/merchants'

      within 'nav' do
        click_link 'Items'
      end

      expect(current_path).to eq('/items')

      within 'nav' do
        click_link 'Merchants'
      end

      expect(current_path).to eq('/merchants')

      within 'nav' do
        click_link 'Login'
      end

      expect(current_path).to eq('/login')

      within 'nav' do
        click_link 'Register'
      end

      expect(current_path).to eq('/register')
    end

    it 'I see a cart indicator in my nav bar' do
      visit '/items'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end
    end

    it 'I see a link to homepage' do
      visit '/merchants'

      within 'nav' do
        click_link 'MonsterShop'
      end
      expect(current_path).to eq('/')
    end

    it 'I see a 404 visiting undefined paths' do
      visit '/apple'

      expect(page.status_code).to eq(404)
    end
  end
end
