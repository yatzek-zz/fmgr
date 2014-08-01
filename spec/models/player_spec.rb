
describe 'Player' do

  it 'has a valid factory' do
    expect(create(:messi)).to be_valid
  end

  it 'is valid without a name' do
    expect(build(:messi, name: nil)).to be_valid
  end

  it 'is valid with a blank name' do
    expect(build(:messi, name: '')).to be_valid
  end

  it 'is valid without a surname' do
    expect(build(:messi, surname: nil)).to be_valid
  end

  it 'is invalid without an email' do
    expect(build(:messi, email: nil)).not_to be_valid
  end

  it 'is invalid without unique email address' do
    create(:messi, email: 'unique@example.com')
    expect(build(:messi, email: 'unique@example.com')).not_to be_valid
  end

end
