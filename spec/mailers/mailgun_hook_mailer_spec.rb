describe 'MailgunHookMailer' do

  describe 'not_delivered' do

    before(:each) do
      @mail = MailgunHookMailer.not_delivered(event: 'dropped', receipient: 'messi@barca.com')
    end

    it 'renders the headers' do
      expect(@mail.subject).to eq 'Email not delivered mailgun hook'
      expect(@mail.to).to eq %w(jacek.szlachta@gmail.com)
      expect(@mail.from).to eq %w(noreply@fmgr.heroku.com)
    end

    it 'renders the body' do
      expect(@mail.body.encoded).to include 'Mailgun failed delivery hook called, params:'
      expect(@mail.body.encoded).to include 'event: dropped'
      expect(@mail.body.encoded).to include 'receipient: messi@barca.com'
    end

  end

end
