require 'rails_helper'


RSpec.describe User, type: :model do
  describe "Validations" do
    it {should validate_presence_of(:user_name)}
    it {should validate_uniqueness_of(:user_name)}
    it {should validate_presence_of(:password)}
		it {should validate_presence_of(:name)}
    it {should validate_presence_of(:address)}
    it {should validate_presence_of(:zip)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
  end

  describe "Relationships" do
    it {should have_many(:orders)}
  end

  describe "roles" do
    it "can be created as an admin" do
      user = User.create!(user_name: "andrew@gmail.com", password: "thinking123", role: 2, name: "Andrew", address: "333 Market St", city: "Denver", state: "CO", zip: 80012 )

      expect(user.role).to eq("admin")
      expect(user.admin?).to be_truthy
    end

    it "can be created as an merchant" do
       user_2 = User.create!(user_name: "nathan@gmail.com", password: "password123", role: 1, name: "Nathan", address: "123 Market St", city: "Denver", state: "CO", zip: 80012 )

      expect(user_2.role).to eq("merchant_admin")
      expect(user_2.merchant_admin?).to be_truthy
    end

    it "can be created as an reg_user" do
       user_3 = User.create!(user_name: "jori@gmail.com", password: "testing123", role: 0, name: "Jori", address: "123 Market St", city: "Denver", state: "CO", zip: 80012 )

      expect(user_3.role).to eq("user")
      expect(user_3.user?).to be_truthy
    end
  end
end
