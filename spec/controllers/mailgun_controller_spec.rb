
describe MailgunController do

  describe "GET 'failed_hook'" do
    it 'returns http success' do
      post 'failed_hook'
      response.should be_success
      last_email.to.should include 'jacek.szlachta@gmail.com'
    end
  end

end
