describe 'GameReminderMailer' do

  describe 'reminder_email' do

    let(:szlachta)  {create(:szlachta)}
    let(:game)      {create(:game, time: Time.local(2013, 1, 29, 12, 0, 0))}

    it 'renders the headers' do
      mail = GameReminderMailer.reminder_email(szlachta, game, false)

      expect(mail.subject).to eq 'Footie reminder - game on Tuesday 29 Jan 2013 at 12:00 at the Goals'
      expect(mail.to).to eq [szlachta.email]
      expect(mail.from).to eq %w(noreply@fmgr.heroku.com)
    end

    it 'renders the body for non-reserve player' do
      mail = GameReminderMailer.reminder_email(szlachta, game, false)
      mail_body = mail.body.encoded

      expect(mail_body).to include 'Do not forget your kit, please.'
      expect(mail_body).to include 'Note that if you <b>cancel on the day</b> of the game and there are no subs, you are expected to pay.'
      expect(mail_body).not_to include 'You are reserve player for this game.'
      expect(mail_body).not_to include 'Please bring your kit in case someone drops out.'
    end

    it 'renders the body for reserve player' do
      mail = GameReminderMailer.reminder_email(szlachta, game, true)
      mail_body = mail.body.encoded

      expect(mail_body).not_to include 'Do not forget your kit, please.'
      expect(mail_body).to include 'You are reserve player for this game.'
      expect(mail_body).to include 'Please bring your kit in case someone drops out.'
    end

  end

end
