describe 'Player' do

  it 'has a valid factory' do
    expect(create(:player)).to be_valid
  end

  it 'is valid without a name' do
    expect(build(:player, name: nil)).to be_valid
  end

  it 'is valid with a blank name' do
    expect(build(:player, name: '')).to be_valid
  end

  it 'is valid without a surname' do
    expect(build(:player, surname: nil)).to be_valid
  end

  it 'is invalid without an email' do
    expect(build(:player, email: nil)).not_to be_valid
  end

  it 'is invalid without unique email address' do
    create(:player, email: 'unique@example.com')
    expect(build(:player, email: 'unique@example.com')).not_to be_valid
  end

  describe 'teamsheet_name' do

    context 'when has name and surname' do

      it 'combines the name and surname' do
        player = build(:player, name: 'Leo', surname: 'Messi')

        expect(player.teamsheet_name).to eq('Leo Messi')
      end

      it 'capitalises the first letter of the name and surname' do
        player = build(:player, name: 'leo', surname: 'messi')

        expect(player.teamsheet_name).to eq('Leo Messi')
      end

      context 'when has just name missing' do

        it 'returns email address if name is nil' do
          player = build(:messi, name: nil)

          expect(player.teamsheet_name).to eq(player.email)
        end

        it 'returns email address if name is ""' do
          player = build(:messi, name: "")

          expect(player.teamsheet_name).to eq(player.email)
        end

      end

      context 'when has just surname missing' do

        it 'returns email address if surname is nil' do
          player = build(:messi, surname: nil)

          expect(player.teamsheet_name).to eq(player.email)
        end

        it 'returns email address if surname is ""' do
          player = build(:messi, surname: "")

          expect(player.teamsheet_name).to eq(player.email)
        end

      end

    end

  end

end
