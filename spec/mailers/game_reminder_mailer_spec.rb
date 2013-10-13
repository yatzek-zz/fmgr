
describe 'GameReminderMailer' do

  describe 'reminder_email' do

    let(:szlachta)  {create(:szlachta)}
    let(:game)      {create(:game, time: Time.local(2013, 1, 29, 12, 0, 0))}
    let(:mail)      {GameReminderMailer.reminder_email(szlachta, game)}

    it 'renders the headers' do
      mail.subject.should == 'Footie reminder - game on Tuesday 29-Jan-2013 12:00 at the Goals'
      mail.to.should == [szlachta.email]
      mail.from.should == %w(noreply@fmgr.heroku.com)
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include 'Do not forget your kit, please.'
      expect(mail.body.encoded).to include '£3.50 change very much appreciated!'
    end

  end

end