require 'spec_helper'
require 'timecop'

describe 'PlayerMailer' do

  describe 'notification_email' do

    TIME_29_01_2013_12_00 = Time.local(2013, 1, 29, 12, 0, 0)

    before(:each) do
      @szlachta = create(:szlachta)
      @game = create(:game, time: TIME_29_01_2013_12_00)
      @mail = PlayerMailer.notification_email(@szlachta, @game)
    end

    it 'renders the headers' do
      @mail.subject.should == 'Want to play 5-a-side on Tuesday 29-Jan-2013 12:00 at the Goals?'
      @mail.to.should == [@szlachta.email]
      @mail.from.should == %w(noreply@fmgr.heroku.com)
    end

    # may fail when ids change - if you use db cleaner gem?
    it 'renders the body' do

      expect(@mail.body.encoded).to include
        'To play click this link: http://fmgr.herokuapp.com/playergame/subscribe/VPkLfUJeuwr_XC0-JVyssA=='
      expect(@mail.body.encoded).to include
        'To unclick the click use this link: http://fmgr.herokuapp.com/playergame/unsubscribe/VPkLfUJeuwr_XC0-JVyssA=='
    end

  end

end