require 'rails_helper'

RSpec.describe Category, :type => :model do

  let!(:category) { FactoryGirl.build(:category) }
  let!(:categoryWParent) { FactoryGirl.build(:categoryWithParent) }
  let!(:categoryWoName) { FactoryGirl.build(:categoryWithoutName) }

  context 'test valid categories' do
    it 'is valid without parent' do
      expect(category).to be_valid
    end
    it 'is valid with parent' do
      expect(categoryWParent).to be_valid
    end
  end

  context 'test invalid categories' do
    it 'is invalid without name' do
      expect(categoryWoName).to_not be_valid
    end

  end

end
