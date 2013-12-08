
describe 'GameReminderMailer' do

  describe 'reminder_email' do

    let(:szlachta)  {create(:szlachta)}
    let(:game)      {create(:game, time: Time.local(2013, 1, 29, 12, 0, 0))}

    it 'renders the headers' do
      mail = GameReminderMailer.reminder_email(szlachta, game, false)
      mail.subject.should == 'Footie reminder - game on Tuesday 29-Jan-2013 12:00 at the Goals'
      mail.to.should == [szlachta.email]
      mail.from.should == %w(noreply@fmgr.heroku.com)
    end

    it 'renders the body for non-reserve player' do
      mail = GameReminderMailer.reminder_email(szlachta, game, false)
      mail_body = mail.body.encoded
      mail_body.should include 'Do not forget your kit, please.'
      mail_body.should include '&pound;4.00 change very much appreciated!'
      mail_body.should_not include 'You are reserve player for this game.'
      mail_body.should_not include 'Please bring your kit in case someone drops out.'
    end

    it 'renders the body for reserve player' do
      mail = GameReminderMailer.reminder_email(szlachta, game, true)
      mail_body = mail.body.encoded
      mail_body.should_not include 'Do not forget your kit, please.'
      mail_body.should_not include '&pound;4.00 change very much appreciated!'
      mail_body.should include 'You are reserve player for this game.'
      mail_body.should include 'Please bring your kit in case someone drops out.'
    end

  end

end
