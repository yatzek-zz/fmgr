require "spec_helper"
require "timecop"

describe 'PlayerMailer' do

  describe "notification_email"  do

    TIME_29_01_2013_12_00 = Time.local(2013, 1, 29, 12, 0, 0)

    before(:each) do
      Timecop.freeze TIME_29_01_2013_12_00
      @szlachta = create(:szlachta)
      @game = create(:game, time: Time.now)
      @mail = PlayerMailer.notification_email @szlachta, @game
    end

    it "renders the headers" do
      @mail.subject.should == "Want to play 5-a-side on Tuesday 29-Jan-2013 12:00 at the Goals?"
      @mail.to.should == [@szlachta.email]
      @mail.from.should == %w(noreply@fmgr.heroku.com)
    end

    # may fail when ids change - if you use db cleaner gem?
    it "renders the body" do
      @mail.body.encoded.should include "To play click this link: http://fmgr.herokuapp.com/play/subscribe/VPkLfUJeuwr_XC0-JVyssA=="
      @mail.body.encoded.should include "To unclick the click above use this link: http://fmgr.herokuapp.com/play/unsubscribe/VPkLfUJeuwr_XC0-JVyssA=="
    end

  end

end


