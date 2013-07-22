require 'spec_helper'

describe 'Player' do

  it 'has a valid factory' do
    create(:messi).should be_valid
  end

  it 'is valid without a name' do
    build(:messi, name: nil).should be_valid
  end

  it 'is valid with a blank name' do
    build(:messi, name: '').should be_valid
  end

  it 'is valid without a surname' do
    build(:messi, surname: nil).should be_valid
  end

  it 'is invalid without an email' do
    build(:messi, email: nil).should_not be_valid
  end

  it 'is invalid without unique email address' do
    create(:messi, email: 'unique@example.com')
    build(:messi, email: 'unique@example.com').should_not be_valid
  end

end
