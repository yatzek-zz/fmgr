require 'spec_helper'

describe MailgunController do

  describe "GET 'failed_hook'" do
    it 'returns http success' do
      post 'failed_hook'
      response.should be_success
      last_email.to.should include 'jacek.szlachta@gmail.com'
    end
  end

  #describe "GET 'delivered_hook'" do
  #  it 'returns http success' do
  #    post 'delivered_hook'
  #    response.should be_success
  #  end
  #end

end
