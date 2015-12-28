describe MailgunController, type: :controller do

  context "GET 'failed_hook'" do

    it 'returns http success' do
      post 'failed_hook'

      expect(response).to be_success
      expect(last_email.to).to include 'jacek.szlachta@gmail.com'
    end

  end

end
