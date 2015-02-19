require 'rails_helper'

RSpec.describe UserToCategory, :type => :model do

  let!(:user_to_category) { FactoryGirl.build(:user_to_category) }
  let!(:categoryWOUser) { FactoryGirl.build(:categoryWithoutUser) }

  context 'test valid user to category' do
    it 'is valid with user to category' do
      expect(user_to_category).to be_valid
    end
  end

  context 'test invalid user to categories' do
    it 'is invalid without user to category' do
      expect(categoryWOUser).to_not be_valid
    end

  end
end
