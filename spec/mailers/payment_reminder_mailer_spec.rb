
describe 'PaymentReminderMailer' do

  describe 'payment_reminder_email' do

    let(:szlachta)  {create(:szlachta)}
    let(:game)      {create(:game, time: Time.local(2013, 1, 29, 12, 0, 0))}

    it 'renders the headers' do
      mail = PaymentReminderMailer.payment_reminder_email(szlachta, game, '£3.80')

      expect(mail.subject).to eq 'Footie payment reminder - game on Tuesday 29-Jan-2013 12:00'
      expect(mail.to).to eq [szlachta.email]
      expect(mail.from).to eq %w(noreply@fmgr.heroku.com)
    end

    it 'renders the body' do
      mail = PaymentReminderMailer.payment_reminder_email(szlachta, game, '£3.80')
      mail_body = mail.body.encoded

      expect(mail_body).to include 'It is £3.80 for the footie today.'
      expect(mail_body).to include 'Please use the following payment details if you have not paid yet.'
    end

  end

end
